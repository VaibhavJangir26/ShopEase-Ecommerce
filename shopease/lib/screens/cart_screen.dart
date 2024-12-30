// File: screens/CartScreen.dart
import 'package:flutter/material.dart';
import 'package:shopease/view_modal/view_category_modal.dart';
import 'package:shopease/models/category_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ViewCategoryModal getCategoryData = ViewCategoryModal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Screen"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<CategoryModal>>(
                future: getCategoryData.fetchCategoryData("men's clothing"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Unable to get the data"));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final categoryItem = snapshot.data![index];
                        return ListTile(
                          leading: categoryItem.image.isNotEmpty
                              ? Image.network(
                            categoryItem.image,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image);
                            },
                          )
                              : Icon(Icons.image_not_supported),
                          title: Text(categoryItem.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("\$${categoryItem.price.toString()}"),
                              Text("Category: ${categoryItem.category}"),
                              Text("Rating: ${categoryItem.rating.rate} (${categoryItem.rating.count} reviews)")
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("Unknown error occurred"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
