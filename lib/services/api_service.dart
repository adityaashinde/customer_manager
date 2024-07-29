import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  String verifyPanUrl = 'http://lab.pixel6.co/api/verify-pan.php';
  String getPostcodeDetailsUrl =
      'http://lab.pixel6.co/api/get-postcode-details.php';

  Future<Map<String, dynamic>> verifyPan(String pan) async {
    final response = await http.post(
      Uri.parse(verifyPanUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'panNumber': pan}),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getPostcodeDetails(String postcode) async {
    final response = await http.post(
      Uri.parse(getPostcodeDetailsUrl),
      headers: {'content-Type': 'appliction/json'},
      body: jsonEncode({'postcode': postcode}),
    );
    return jsonDecode(response.body);
  }
}
