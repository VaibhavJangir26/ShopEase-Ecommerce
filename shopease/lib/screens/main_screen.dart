import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shopease/screens/cart_screen.dart';
import 'package:shopease/screens/favourite_items_screen.dart';
import 'package:shopease/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentScreenIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const FavouriteItemsScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Ensure that the body of the Scaffold is switched properly
      body: IndexedStack(
        index: currentScreenIndex,
        children: screens,
      ),

      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(Icons.home),
          Icon(Icons.favorite),
          Icon(Icons.shopping_cart),
        ],
        backgroundColor: Colors.blue.shade50,
        color: Theme.of(context).scaffoldBackgroundColor,
        index: currentScreenIndex,
        height: 50,
        // Prevent layout issues by ensuring setState is used properly
        onTap: (index) {
          if (currentScreenIndex != index) {
            setState(() {
              currentScreenIndex = index;
            });
          }
        },
      ),
    );
  }
}
