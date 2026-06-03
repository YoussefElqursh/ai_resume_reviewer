import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return "10.0.2.2:5001";
    }
    return "localhost:5001";
  }

  static Future<Map<String, dynamic>> analyzeResume(File file) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://$baseUrl/analyze-resume'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();
        return json.decode(data);
      } else {
        final errorData = await response.stream.bytesToString();
        throw Exception('Failed to analyze resume: ${response.statusCode} - $errorData');
      }
    } catch (e) {
      throw Exception('Failed to analyze resume: $e');
    }
  }
}
