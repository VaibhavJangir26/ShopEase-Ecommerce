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

  static final ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: notifier,
      builder: (context, mode, child) {
        return MaterialApp(

          theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
              colorScheme: const ColorScheme.light().copyWith(
                  primary: Colors.blue.shade200),
              primaryColor: Colors.white,
              scaffoldBackgroundColor: Colors.white
          ),
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blue,
              colorScheme: const ColorScheme.dark().copyWith(primary: Colors.blueGrey),
              primaryColor: Colors.black,
              scaffoldBackgroundColor: Colors.black12
          ),
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {
            "/": (context) => const SplashScreen(),
            "/home": (context) => const HomeScreen(),
            "/login": (context) => const Login(),
            "/signup": (context) => const Signup(),
          },
        );
      },

    );
  }
}