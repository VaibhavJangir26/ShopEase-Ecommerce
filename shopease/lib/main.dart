import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopease/auth/login.dart';
import 'package:shopease/auth/signup.dart';
import 'package:shopease/firebase_options.dart';
import 'package:shopease/screens/home_screen.dart';
import 'package:shopease/screens/splash_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopEase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context)=> const SplashScreen(),
        "/home": (context)=> const HomeScreen(),
        "/login": (context)=> const Login(),
        "/signup": (context)=> const Signup(),
      },
    );
  }
}

