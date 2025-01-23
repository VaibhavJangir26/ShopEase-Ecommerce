// import 'package:sqflite/sqflite.dart';
// import 'dart:io' as io;
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import '../models/cart_model.dart';
//
// class CartDatabase {
//   static Database? _db;
//
//   // Get the database instance
//   Future<Database> get database async {
//     if (_db != null) {
//       return _db!;
//     }
//     _db = await initDatabase(); // Initialize the database if not already initialized
//     return _db!;
//   }
//
//   // Initialize the database
//   Future<Database> initDatabase() async {
//     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, 'cart.db'); // Database file name
//
//     // Open or create the database
//     var db = await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//     return db;
//   }
//
//   // Create the cart table in the database
//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute(
//       'CREATE TABLE cart (id INTEGER PRIMARY KEY AUTOINCREMENT, productId VARCHAR UNIQUE, productName TEXT, initialPrice DOUBLE, pdtPrice DOUBLE, quantity INTEGER, image TEXT)',
//     );
//   }
//
//   // Insert a cart item into the database
//   Future<void> insertCartItem(CartModel cart) async {
//     var dbClient = await database;
//     await dbClient.insert('cart', cart.toJson(), conflictAlgorithm: ConflictAlgorithm.replace); // Insert or replace item if exists
//   }
//
//   // Fetch all cart items from the database
//   Future<List<CartModel>> getCartItems() async {
//     var dbClient = await database;
//     final List<Map<String, dynamic>> queryResult = await dbClient.query('cart');
//     return queryResult.map((e) => CartModel.fromJson(e)).toList();
//   }
//
//   // Delete a cart item by product ID
//   Future<void> deleteCartItem(String productId) async {
//     var dbClient = await database;
//     await dbClient.delete('cart', where: 'productId = ?', whereArgs: [productId]);
//   }
//
//   // Update the quantity of a cart item
//   Future<void> updateCartItemQuantity(CartModel cart) async {
//     var dbClient = await database;
//     await dbClient.update('cart', cart.toJson(), where: 'productId = ?', whereArgs: [cart.productId]);
//   }
//
//   // Clear all cart items from the database
//   Future<void> clearCart() async {
//     var dbClient = await database;
//     await dbClient.delete('cart');
//   }
// }


class CartDatabase{

}