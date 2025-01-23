import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopease/auth/login.dart';
import 'package:shopease/auth/signup.dart';
import 'package:shopease/firebase_options.dart';
import 'package:shopease/provider/wishlist_provider.dart';
import 'package:shopease/screens/cart_screen.dart';
import 'package:shopease/screens/favourite_items_screen.dart';
import 'package:shopease/screens/home_screen.dart';
import 'package:shopease/screens/main_screen.dart';
import 'package:shopease/screens/show_ac_products.dart';
import 'package:shopease/screens/show_trending_products.dart';
import 'package:shopease/screens/splash_screen.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ValueListenableProvider<ThemeMode>.value(value: notifier),

        ChangeNotifierProvider(create: (context)=> WishlistProvider()),
      ],
      child: Consumer<ThemeMode>(
        builder: (context, themeMode, _) {
          return MaterialApp(
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: const Color(0xff3d5a80),
              scaffoldBackgroundColor: Colors.white,
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
              scaffoldBackgroundColor: Colors.black26,
              colorScheme: const ColorScheme.dark().copyWith(
                primary: const Color(0xff293241),
                secondary: const Color(0xffee6c4d),
                surface: const Color(0xff98c1d9),
                onPrimary: const Color(0xffe0fbfc),
                onSecondary: const Color(0xffe0fbfc),
              ),
            ),
            themeMode: themeMode, // Use the provided theme mode directly
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            routes: {
              "/": (context) => const SplashScreen(),
              "/main": (context) => const MainScreen(),
              "/home": (context) => const HomeScreen(),
              "/login": (context) => const Login(),
              "/signup": (context) => const Signup(),
              "/favourite": (context) => const FavouriteItemsScreen(),
              "/cart": (context) => const CartScreen(),
              "/trending": (context) => const ShowTrendingProducts(),
              "/airConditioner": (context) => const ShowAcProducts(),
            },
          );
        },
      ),
    );
  }
}
