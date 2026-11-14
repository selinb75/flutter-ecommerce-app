import 'package:benim_uygulamam/models/products_model.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

//import 'package:benim_uygulamam/models/new_model.dart';

class ApiService {
  Future<ProductsModel> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://wantapi.com/products.php'),
    ); // zamana baglı olarak değişen bir veri kaynağına bağlanmak için http.get() kullanılır. Bu örnekte, JSONPlaceholder API'sinden gönderileri almak için bir GET isteği yapılır.
    //parse → String türündeki URL'yi Uri türüne dönüştürmek için kullanılır. Uri.parse() metodu, geçerli bir URI oluşturmak için verilen URL'yi ayrıştırır.
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ProductsModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
