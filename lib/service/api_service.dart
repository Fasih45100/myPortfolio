import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/skill.dart';

class ApiService {
  static const String _mockApiUrl =
      'https://mocki.io/v1/3a5b6d9e-5f4a-46a7-b8c5-6e4b3f2b1a0d'; // Mock API

  static Future<List<Skill>> fetchSkills() async {
    final response = await http.get(Uri.parse(_mockApiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Skill.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load skills');
    }
  }
}
