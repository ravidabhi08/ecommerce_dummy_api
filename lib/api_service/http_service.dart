import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dummy_api/model/model.dart';

Future<List<Products>> fetchItemHomeData() async {
  // Replace this URL with your API endpoint
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    final data = json.decode(response.body);
    final products = data["products"] as List<dynamic>;
    return products.map((json) => Products.fromJson(json)).toList();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load data');
  }
}

Future<List<Products>> fetchItemData({required String category}) async {
  // Replace this URL with your API endpoint
  if (category == "home") {
    fetchItemHomeData();
  } else {
    fetchItemData(category: category);
  }
  final response = await http
      .get(Uri.parse('https://dummyjson.com/products/category/$category'));
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON

    final data = json.decode(response.body);
    final products = data["products"] as List<dynamic>;
    return products.map((json) => Products.fromJson(json)).toList();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load data');
  }
}

Future<Products> fetchItemId({required int id}) async {
  // Replace this URL with your API endpoint
  final response =
      await http.get(Uri.parse('https://dummyjson.com/products/$id'));
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    final data = json.decode(response.body);
    return Products.fromJson(data);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load data');
  }
}
