// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:shopease/screens/cart_screen.dart';
// import 'package:shopease/screens/favourite_items_screen.dart';
// import 'package:shopease/screens/home_screen.dart';
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//
//   int currentScreenIndex = 0;
//
//   List<GlobalKey<NavigatorState>> navigatorKeys=[
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//   ];
//
//   void changeScreen(int index){
//     if(currentScreenIndex == index){
//       navigatorKeys[index].currentState!.popUntil((route)=>route.isFirst);
//     }
//     else{
//       currentScreenIndex=index;
//     }
//   }
//
//   Widget buildNavigator(Widget screen,int index){
//     return Navigator(
//       key: navigatorKeys[index],
//       onGenerateRoute: (routeSetting){
//         return MaterialPageRoute(builder: (context)=> screen);
//       },
//     );
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: currentScreenIndex,
//         children: [
//           buildNavigator(const HomeScreen(), 0),
//           buildNavigator(const FavouriteItemsScreen(), 1),
//           buildNavigator(const CartScreen(), 2),
//         ],
//       ),
//
//       bottomNavigationBar: CurvedNavigationBar(
//         height: 50,
//         items: const [
//           Icon(Icons.home),
//           Icon(Icons.favorite),
//           Icon(Icons.shopping_cart),
//         ],
//         index: currentScreenIndex,
//         onTap: (index) {
//           setState(() {
//             changeScreen(index);
//           });
//         },
//       ),
//     );
//   }
// }

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

  List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void changeScreen(int index) {
    if (currentScreenIndex == index) {
      navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentScreenIndex = index;
      });
    }
  }

  Future<bool> onWillPop() async {
    final isFirstRouteInCurrentTab =
    !await navigatorKeys[currentScreenIndex].currentState!.maybePop();
    if (isFirstRouteInCurrentTab) {
      if (currentScreenIndex != 0) {
        setState(() {
          currentScreenIndex = 0;
        });
        return false;
      }
    }
    return isFirstRouteInCurrentTab;
  }

  Widget buildNavigator(Widget screen, int index) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Navigator(
        key: navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(builder: (context) => screen);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentScreenIndex,
        children: [
          buildNavigator(const HomeScreen(), 0),
          buildNavigator(const FavouriteItemsScreen(), 1),
          buildNavigator(const CartScreen(), 2),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        items: const [
          Icon(Icons.home),
          Icon(Icons.favorite),
          Icon(Icons.shopping_cart),
        ],
        index: currentScreenIndex,
        onTap: (index) {
          changeScreen(index);
        },
      ),
    );
  }
}
