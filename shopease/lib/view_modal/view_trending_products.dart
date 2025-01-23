import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/trending_model.dart';

class ViewTrendingProducts {

  final String localJson = "assets/jsonFiles/trending_product.json";

  Future<List<TrendingModel>> fetchTrendingProducts() async {
    try {
      var response = await rootBundle.loadString(localJson);
      var jsonData = jsonDecode(response);

      if (jsonData.containsKey('products')) {
        List<dynamic> productsList = jsonData['products'];
        List<TrendingModel> trendingProducts = productsList.map((product) => TrendingModel.fromJson(product)).toList();
        return trendingProducts;
      } else {
        throw Exception("Unexpected JSON format missing 'products' key");
      }

    } catch (error) {
      throw Exception("Failed to load trending products: $error");
    }
  }


}
