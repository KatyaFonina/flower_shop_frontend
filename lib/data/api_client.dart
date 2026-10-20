import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static const String baseUrl = 'http://localhost:4000/api';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
  }

  static Future<Map<String, String>> _headers({bool auth = false}) async {
    final h = {'Content-Type': 'application/json'};
    if (auth) {
      final token = await getToken();
      if (token != null) h['Authorization'] = 'Bearer $token';
    }
    return h;
  }

  static Future<String> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: await _headers(),
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (res.statusCode != 200) {
      throw Exception('Login failed: ${res.body}');
    }
    final data = jsonDecode(res.body);
    final token = data['token'] as String;
    await saveToken(token);
    return token;
  }

  static Future<void> register(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: await _headers(),
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (res.statusCode != 201) {
      throw Exception('Register failed: ${res.body}');
    }
  }

  static Future<List<Map<String, dynamic>>> getFlowers() async {
    final res = await http.get(
      Uri.parse('$baseUrl/flowers'),
      headers: await _headers(),
    );
    if (res.statusCode != 200) {
      throw Exception('Failed to load flowers');
    }
    final list = jsonDecode(res.body) as List;
    return list.cast<Map<String, dynamic>>();
  }

  static Future<void> createOrder({
    required List<Map<String, dynamic>> items,
    required int total,
    String? address,
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: await _headers(auth: true),
      body: jsonEncode({
        'items': items,
        'total': total,
        'address': address,
      }),
    );
    if (res.statusCode != 201) {
      throw Exception('Create order failed: ${res.body}');
    }
  }

  static Future<List<Map<String, dynamic>>> getOrders() async {
    final res = await http.get(
      Uri.parse('$baseUrl/orders'),
      headers: await _headers(auth: true),
    );
    if (res.statusCode != 200) {
      throw Exception('Load orders failed: ${res.body}');
    }
    final list = jsonDecode(res.body) as List;
    return list.cast<Map<String, dynamic>>();
  }
}
