import 'package:flutter/foundation.dart';

class WishlistProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _wishListItems = [];

  List<Map<String, dynamic>> get wishListItems => _wishListItems;

  void addItemToFav(String name, String desc, double price, String image) {
    _wishListItems.add({
      'name': name,
      'desc': desc,
      'price': price,
      'image': image,
    });
    notifyListeners();
  }

  void removeItemFromFav(String name) {
    _wishListItems.removeWhere((item) => item['name'] == name);
    notifyListeners();
  }
}
