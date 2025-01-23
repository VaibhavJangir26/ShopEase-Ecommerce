import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopease/provider/wishlist_provider.dart';

class FavouriteItemsScreen extends StatefulWidget {
  const FavouriteItemsScreen({super.key});

  @override
  State<FavouriteItemsScreen> createState() => _FavouriteItemsScreenState();
}

class _FavouriteItemsScreenState extends State<FavouriteItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<WishlistProvider>(
          builder: (context, value, child) {
            return value.wishListItems.isEmpty
                ? const Center(child: Text("Your wishlist is empty."))
                : ListView.builder(
              itemCount: value.wishListItems.length,
              itemBuilder: (context, index) {
                final item = value.wishListItems[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(item['image'], width: 50, height: 50),
                    title: Text(item['name'],maxLines: 2,overflow: TextOverflow.ellipsis ,style: const TextStyle(fontWeight: FontWeight.w600),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['desc'],maxLines: 2,overflow: TextOverflow.ellipsis,),
                        Text(
                          "Rs ${(item['price'] * 85).toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),

                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        value.removeItemFromFav(item['name']);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
