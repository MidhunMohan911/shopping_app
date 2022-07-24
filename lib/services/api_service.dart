import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future getAllPosts() async {
    final allProductUrl = Uri.parse('https://fakestoreapi.com/products');
    final response = await http.get(allProductUrl);
    // print(response.statusCode);
    // print(response.body);
    return json.decode(response.body);
  }

  Future getSingleLProduct(int id) async {
    final singleProductUrl = Uri.parse('https://fakestoreapi.com/products/$id');
    final response = await http.get(singleProductUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getAllCategory() async {
    final getAllCategoryUrl =
        Uri.parse('https://fakestoreapi.com/products/categories');
    final response = await http.get(getAllCategoryUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getProductByCategory(String catName) async {
    final fetchProductCategoryUrl =
        Uri.parse('https://fakestoreapi.com/products/category/$catName');
    final response = await http.get(fetchProductCategoryUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getCart(String userId) async {
    final fetchCartUrl = Uri.parse('https://fakestoreapi.com/carts/$userId');
    final response = await http.get(fetchCartUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  //Post Method
  Future userLogin(String username, String password) async {
    final loginUrl = Uri.parse('https://fakestoreapi.com/auth/login');
    final response = await http.post(loginUrl, body: {
      'username': username,
      'password': password,
    });
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  //Put Method
  Future updateCart(int userId, int productId) async {
    final updateCart = Uri.parse('https://fakestoreapi.com/carts/$userId');
    final response = await http.put(updateCart, body: {
      'userId': '$userId',
      'date': DateTime.now().toString(),
      'products': [
        {
          'productId': '$productId',
          'quantity': '1',
        }
      ].toString()
    });
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  //Delete Method
  Future deleteCart(int userId) async {
    final deleteCart = Uri.parse('https://fakestoreapi.com/carts/$userId');
    final response = await http.delete(deleteCart);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }
}
