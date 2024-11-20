import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopease/methods/toast_message.dart';

import '../main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool isPassVisible=false;
  final _formKey=GlobalKey<FormState>();
  void showPassword(){
    setState(() {
      isPassVisible=!isPassVisible;
    });
  }
  bool isLoading=false;
  final auth=FirebaseAuth.instance;
  Future<void> login(String email,String password) async{
    setState(() {
      isLoading=true;
    });
    await auth.signInWithEmailAndPassword(email: email, password: password).then((value){
      setState(() {
        isLoading=false;
      });
      Navigator.pushReplacementNamed(context, "/home");
    }).onError((error,stackTrace){
      setState(() {
        isLoading=false;
      });
      ToastMessage().showToastMsg(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: width,
                height: height,
                decoration:  BoxDecoration(
                  gradient: MyApp.notifier.value== ThemeMode.light?const LinearGradient(colors: [
                    // this is for light theme
                    Color(0xfffff1eb),
                    Color(0xfface0f9),
                  ]): const LinearGradient(colors: [
                    // this is for dark theme
                    Color(0xff09203f),
                    Color(0xff537895),
                  ]),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: width*.85,
                  height: height*.8,
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text("Welcome Back!",style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold),),
                        TextFormField(
                          enableSuggestions: true,
                          enableIMEPersonalizedLearning: true,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(emailController.text.isEmpty){
                              return "Enter the email";
                            }
                            if(!value!.contains('@')){
                              return "Enter a valid mail";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: const Icon(Icons.person,),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.grey)
                              )
                          ),
                        ),
                        SizedBox(height: height*.02,),
                        TextFormField(
                          controller: passwordController,
                          obscureText: isPassVisible?false:true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value){
                            if(passwordController.text.isEmpty){
                              return "Enter the Password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: const Icon(Icons.lock,),
                              suffixIcon: IconButton(
                                onPressed: showPassword,
                                icon: isPassVisible?const Icon(Icons.remove_red_eye):const Icon(CupertinoIcons.eye_slash_fill),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.grey)
                              )
                          ),
                        ),
                        Container(
                          width: width,
                          height: height*.04,
                          alignment: Alignment.centerRight,
                          child: const Text("forgot password?",style: TextStyle(color: Colors.blue),),
                        ),
                        Container(
                          width: width*.6,
                          height: height*.095,
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                            ),
                            onPressed: (){
                              setState(() {
                                setState(() {
                                  isLoading=false;
                                });
                                if(_formKey.currentState!.validate()){
                                  login(emailController.text.toString(), passwordController.text.toString());
                                }
                              });
                            },
                            child: isLoading?const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2.5,)):const Text("Login",style: TextStyle(fontSize: 15),),
                          ),
                        ),
                        Container(
                          width: width,
                          height: height*.04,
                          alignment: Alignment.center,
                          child: const Text("-or Continue with-"),
                        ),
                        Container(
                          width: width,
                          height: height*.08,
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                foregroundImage: AssetImage("assets/images/googlelogo.png"),
                                foregroundColor: Colors.grey,
                              ),
                              SizedBox(width: width*.02,),
                              const CircleAvatar(
                                foregroundColor: Colors.grey,
                                foregroundImage: AssetImage("assets/images/facebooklogo.png"),
                              ),
                            ],
                          ),

                        ),
                        SizedBox(height: height*.005,),
                        Container(
                          width: width,
                          height: height*.05,
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Create an Account?"),
                              SizedBox(width: width*.025,),
                              InkWell(
                                onTap: ()=>Navigator.pushNamed(context, "/signup"),
                                  child: const Text("Sign Up",style: TextStyle(color: Colors.pink),)),
                            ],
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
