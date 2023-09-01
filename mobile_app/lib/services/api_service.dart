import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<dynamic>> fetchShops() async {
    final response = await http.get(Uri.parse('$baseUrl/shops')); // Remplacez '/shops' par l'endpoint approprié si différent.

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load shops');
    }
  }
}
