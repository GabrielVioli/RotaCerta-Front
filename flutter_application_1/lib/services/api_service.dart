import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static String? token;

  static Future<bool> login(String email, String senha) async {
    final resposta = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': senha}),
    );

    if (resposta.statusCode == 200) {
      final dados = jsonDecode(resposta.body);
      token = dados['token'];
      return true;
    }

    return false;
  }
}
