import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchStoreService {
  Future<List<String>> findBookStores(String isbn) async {
    final response = await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=isbn:$isbn'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return List<String>.from(data['items'].map((item) => item['saleInfo']['buyLink'] ?? ''));
    } else {
      throw Exception('Failed to load book stores');
    }
  }
}
