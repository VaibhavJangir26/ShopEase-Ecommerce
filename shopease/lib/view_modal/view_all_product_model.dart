// File: view_modal/view_all_product_model.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopease/models/all_product_model.dart';

class ViewAllProductModel {
  Future<List<AllProductModel>> fetchAllProductData() async {
    String url = 'https://fakestoreapi.com/products';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((item) => AllProductModel.fromJson(item)).toList();
    } else {
      throw Exception("Unable to fetch data from the API");
    }
  }
}
