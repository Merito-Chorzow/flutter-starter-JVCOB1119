import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class ApiService {
  // - Android Emulator: 10.0.2.2 (host PC)
  // - Web/Windows/iOS Simulator: localhost
  static String get baseUrl {
    if (!kIsWeb && Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    }
    return 'http://localhost:3000';
  }

  // GET: lista wpisów
  static Future<List<dynamic>> fetchEntries() async {
    final uri = Uri.parse('$baseUrl/entries');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is List) return decoded;
      throw Exception('API: nieprawidłowy format (oczekiwano listy).');
    }
    throw Exception('Błąd pobierania wpisów: ${response.statusCode}');
  }

  // GET: szczegóły wpisu
  static Future<Map<String, dynamic>> fetchEntry(int id) async {
    final uri = Uri.parse('$baseUrl/entries/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
      throw Exception('API: nieprawidłowy format (oczekiwano obiektu).');
    }
    if (response.statusCode == 404) {
      throw Exception('Nie znaleziono wpisu (404).');
    }
    throw Exception('Błąd pobierania wpisu: ${response.statusCode}');
  }

  // POST: dodanie wpisu
  static Future<void> createEntry(Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl/entries');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Błąd dodawania wpisu: ${response.statusCode} ${response.body}');
    }
  }

  // DELETE: usunięcie wpisu
  static Future<void> deleteEntry(int id) async {
    final uri = Uri.parse('$baseUrl/entries/$id');
    final response = await http.delete(uri);

    // JSON Server zwykle zwraca 200
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Błąd usuwania wpisu: ${response.statusCode} ${response.body}');
    }
  }
}
