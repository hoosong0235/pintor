import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatController {
  String key = 'Bearer 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';
  String authority = 'api.openai.com';
  String error =
      'https://e7.pngegg.com/pngimages/10/205/png-clipart-computer-icons-error-information-error-angle-triangle.png';

  Future<String> generate(String string) async {
    try {
      http.Response response = await http.post(
        Uri.https(authority, '/v1/images/generations'),
        headers: {
          'content-type': 'application/json',
          'Authorization': key,
        },
        body: jsonEncode({
          'prompt': string,
          'n': 1,
        }),
      );

      dynamic body = jsonDecode(response.body);

      return body['data'][0]['url'];
    } catch (e) {
      return error;
    }
  }
}
