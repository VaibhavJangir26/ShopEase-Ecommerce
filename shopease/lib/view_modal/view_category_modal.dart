import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';

class ViewCategoryModal {

  Future<List<CategoryModal>> fetchCategoryData(String category) async {
    String url = 'https://fakestoreapi.com/products/category/$category';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((item)=>CategoryModal.fromJson(item)).toList();
    } else {
      throw Exception("Unable to fetch data from API");
    }
  }

}


