import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopease/auth/login.dart';
import 'package:shopease/auth/signup.dart';
import 'package:shopease/firebase_options.dart';
import 'package:shopease/screens/home_screen.dart';
import 'package:shopease/screens/main_screen.dart';
import 'package:shopease/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
            primaryColor: const Color(0xff3d5a80),
            scaffoldBackgroundColor: const Color(0xffe0fbfc),
            colorScheme: const ColorScheme.light().copyWith(
              primary: const Color(0xff3d5a80),
              secondary: const Color(0xffee6c4d),
              surface: const Color(0xff98c1d9),
              onPrimary: const Color(0xffe0fbfc),
              onSecondary: const Color(0xff293241),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xff293241),
            scaffoldBackgroundColor: const Color(0xff3d5a80),
            colorScheme: const ColorScheme.dark().copyWith(
              primary: const Color(0xff293241),
              secondary: const Color(0xffee6c4d),
              surface: const Color(0xff98c1d9),
              onPrimary: const Color(0xffe0fbfc),
              onSecondary: const Color(0xffe0fbfc),
            ),
          ),
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {
            "/": (context) => const SplashScreen(),
            "/main": (context) => const MainScreen(),
            "/home": (context) => const HomeScreen(),
            "/login": (context) => const Login(),
            "/signup": (context) => const Signup(),
          },
        );
      },
    );
  }
}
