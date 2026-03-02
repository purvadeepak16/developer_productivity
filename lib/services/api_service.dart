import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://7s1vfocfeg.execute-api.ap-south-1.amazonaws.com";

  static Future<Map<String, dynamic>> generateRoadmap(String language) async {
    final url = Uri.parse("$baseUrl/generate-roadmap");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "language": language,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load roadmap");
    }
  }
}
