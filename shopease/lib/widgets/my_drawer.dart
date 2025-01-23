import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/main.dart';

import '../methods_and_ui/toast_message.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {

  bool isAppLockEnabled=false;

  @override
  void initState() {
    super.initState();
    getSavedUserInfo();
  }

  Future<Map<String,String?>> getSavedUserInfo()async{
   final prefs=await SharedPreferences.getInstance();
   var savedEmail=prefs.getString("email");
   var savedPass=prefs.getString("pass");
   var savedName=prefs.getString("name");
   return {"savedEmail": savedEmail,"savedPass": savedPass,"savedName": savedName};
  }

  final auth=FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    return Drawer(
      width: width/1.3,
      child: FutureBuilder(
        future: getSavedUserInfo(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(strokeWidth: 2,),),);
          }
          else if(snapshot.hasError){
            return const Center(child: Text("Unable to Load!"),);
          }
          else{
            return Column(
              children: [





                changeTheme(),

                logoutButton(),




              ],
            );
          }
        },
      ),
    );
  }

  Widget changeTheme(){
    return ListTile(
      leading: MyApp.notifier.value == ThemeMode.light?const Icon(Icons.sunny): const Icon(Icons.dark_mode),
      title: MyApp.notifier.value == ThemeMode.light?const Text("Light Theme"): const Text("Dark Theme"),
      onTap: (){MyApp.notifier.value = MyApp.notifier.value == ThemeMode.light ? ThemeMode.dark: ThemeMode.light;
      Navigator.pop(context);
      },
    );
  }

  Widget logoutButton(){
    return ListTile(
      leading: const Icon(Icons.logout),
      title: const Text("Logout"),
      onTap: ()async{
        await auth.signOut().then((value){
          Navigator.pushReplacementNamed(context, "/login");
        }).onError((error,stackTrace){
          ToastMessage().showToastMsg(error.toString());
        });
      },
    );
  }



}
