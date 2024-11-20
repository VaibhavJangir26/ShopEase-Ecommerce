import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/main.dart';
import 'package:shopease/methods/toast_message.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

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
                UserAccountsDrawerHeader(
                  currentAccountPicture: const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/pic.jpg",)),
                  accountName: Text(snapshot.data!["savedName"]??"Not Saved"),
                  accountEmail:Text(snapshot.data!["savedEmail"]??"Not Saved\n ${snapshot.data!["savedPass"]??"Not Saved"}"),
                ),
                ListTile(
                  leading: MyApp.notifier.value == ThemeMode.light?const Icon(Icons.sunny): const Icon(Icons.dark_mode),
                  title: MyApp.notifier.value == ThemeMode.light?const Text("Light Theme"): const Text("Dark Theme"),
                  onTap: (){
                    setState(() {
                      MyApp.notifier.value = MyApp.notifier.value == ThemeMode.light ? ThemeMode.dark: ThemeMode.light;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap: ()async{
                    await auth.signOut().then((value){
                      Navigator.pushReplacementNamed(context, "/login");
                    }).onError((error,stackTrace){
                      ToastMessage().showToastMsg(error.toString());
                    });
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
