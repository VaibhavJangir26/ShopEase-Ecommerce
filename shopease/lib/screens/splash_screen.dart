import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    whichScreen();
  }


  whichScreen(){
    final auth=FirebaseAuth.instance;
    User? user=auth.currentUser;
    if(user!=null){
      Navigator.pushReplacementNamed(context, "/home");
    }
    Timer(const Duration(seconds: 4),(){
      Navigator.pushReplacementNamed(context, "/login");
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
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xfffff1eb),
                  Color(0xfface0f9),
                ])
              ),
            ),
            Container(
              width: width*.8,
              height: height*.2,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              child: Text("ShopEase",style: GoogleFonts.italiana(fontSize: 45,fontWeight: FontWeight.bold,color: Colors.blue.shade400)),
            ),
          ]
        )
      ),
    );
  }
}
