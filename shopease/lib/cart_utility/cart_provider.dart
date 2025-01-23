// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/cart_model.dart';
// import 'cart_database.dart';
//
// class CartProvider with ChangeNotifier {
//   CartDatabase db = CartDatabase(); // Reference to the CartDatabase for CRUD operations
//   int _totalCount = 0;  // Total number of items in the cart
//   double _totalPrice = 0.0;  // Total price of all items in the cart
//
//   // Getter for total item count
//   int get totalCount => _totalCount;
//
//   // Getter for total price
//   double get totalPrice => _totalPrice;
//
//   // Fetch cart items and update total count and price
//   Future<List<CartModel>> getCartData() async {
//     List<CartModel> cartItems = await db.getCartItems();
//     _totalCount = cartItems.length;
//     _totalPrice = cartItems.fold(0.0, (sum, item) => sum + (item.pdtPrice ?? 0.0) * (item.quantity ?? 0));
//     notifyListeners();
//     return cartItems; // Return the list of cart items
//   }
//
//
//   // Add or update a product in the cart
//   Future<void> addOrUpdateItem(CartModel cartItem) async {
//     await db.insertCartItem(cartItem);  // Insert or update cart item in the database
//     await getCartData();  // Refresh the cart data after adding/updating an item
//     notifyListeners();  // Notify listeners to rebuild the UI
//   }
//
//   // Remove a product from the cart
//   Future<void> removeItem(String productId) async {
//     await db.deleteCartItem(productId);  // Delete the item from the database
//     await getCartData();  // Refresh the cart data after removal
//     notifyListeners();  // Notify listeners to rebuild the UI
//   }
//
//   // Update the quantity of a cart item
//   Future<void> updateQuantity(CartModel cartItem) async {
//     await db.updateCartItemQuantity(cartItem);  // Update the item quantity in the database
//     await getCartData();  // Refresh the cart data after updating the quantity
//     notifyListeners();  // Notify listeners to rebuild the UI
//   }
//
//   // Clear the entire cart
//   Future<void> clearCart() async {
//     await db.clearCart();  // Clear all items from the cart
//     await getCartData();  // Refresh the cart data after clearing
//     notifyListeners();  // Notify listeners to rebuild the UI
//   }
//
//   // Store total price and total item count in SharedPreferences
//   Future<void> storeCartPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt("cart_total_count", _totalCount);  // Store total count of items
//     await prefs.setDouble("cart_total_price", _totalPrice);  // Store total price of items
//   }
//
//   // Fetch the stored cart data from SharedPreferences
//   Future<int> fetchCartPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _totalCount = prefs.getInt("cart_total_count") ?? 0;  // Fetch total count of items
//     _totalPrice = prefs.getDouble("cart_total_price") ?? 0.0;  // Fetch total price of items
//     return _totalCount;
//     notifyListeners();  // Notify listeners to rebuild the UI
//   }
// }


class CartProvider{


}