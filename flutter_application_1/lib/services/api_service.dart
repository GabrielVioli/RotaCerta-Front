import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/pedido.dart';
import '../models/item.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static String? token;

  static Map<String, String> get headers => {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  static void verificar(http.Response resposta, List<int> aceitos) {
    if (!aceitos.contains(resposta.statusCode)) {
      throw Exception('Erro ${resposta.statusCode}: ${resposta.body}');
    }
  }

  // LOGIN
  static Future<bool> login(String email, String senha) async {
    final resposta = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: headers,
      body: jsonEncode({'email': email, 'password': senha}),
    );

    if (resposta.statusCode == 200) {
      token = jsonDecode(resposta.body)['token'];
      return true;
    }

    return false;
  }

  // CLIENTES
  static Future<Map<String, dynamic>> criarCliente(
    String nome,
    String telefone,
  ) async {
    final resposta = await http.post(
      Uri.parse('$baseUrl/clientes'),
      headers: headers,
      body: jsonEncode({'nome': nome, 'telefone': telefone}),
    );

    verificar(resposta, [201]);
    return jsonDecode(resposta.body);
  }

  static Future<Map<String, dynamic>> buscarCliente(int id) async {
    final resposta = await http.get(
      Uri.parse('$baseUrl/clientes/$id'),
      headers: headers,
    );

    verificar(resposta, [200]);
    return jsonDecode(resposta.body);
  }

  static Future<void> editarCliente(
    int id,
    String nome,
    String telefone,
  ) async {
    final resposta = await http.put(
      Uri.parse('$baseUrl/clientes/$id'),
      headers: headers,
      body: jsonEncode({'nome': nome, 'telefone': telefone}),
    );

    verificar(resposta, [200]);
  }

  // PEDIDOS
  static Future<List<Pedido>> listarPedidos() async {
    final resposta = await http.get(
      Uri.parse('$baseUrl/pedidos'),
      headers: headers,
    );

    verificar(resposta, [200]);

    final List dados = jsonDecode(resposta.body);
    return dados.map((e) => Pedido.fromJson(e)).toList();
  }

  static Future<Pedido> buscarPedido(int id) async {
    final resposta = await http.get(
      Uri.parse('$baseUrl/pedidos/$id'),
      headers: headers,
    );

    verificar(resposta, [200]);
    return Pedido.fromJson(jsonDecode(resposta.body));
  }

  static Future<void> criarPedido(Map<String, dynamic> dados) async {
    final resposta = await http.post(
      Uri.parse('$baseUrl/pedidos'),
      headers: headers,
      body: jsonEncode(dados),
    );

    verificar(resposta, [201]);
  }

  static Future<void> editarPedido(int id, Map<String, dynamic> dados) async {
    final resposta = await http.put(
      Uri.parse('$baseUrl/pedidos/$id'),
      headers: headers,
      body: jsonEncode(dados),
    );

    verificar(resposta, [200]);
  }

  static Future<void> excluirPedido(int id) async {
    final resposta = await http.delete(
      Uri.parse('$baseUrl/pedidos/$id'),
      headers: headers,
    );

    verificar(resposta, [204]);
  }

  static Future<void> alterarStatus(int id, String status) async {
    final resposta = await http.patch(
      Uri.parse('$baseUrl/pedidos/$id/status'),
      headers: headers,
      body: jsonEncode({'status': status}),
    );

    verificar(resposta, [200]);
  }

  // ITENS
  static Future<List<Item>> listarItens() async {
    final resposta = await http.get(
      Uri.parse('$baseUrl/itens'),
      headers: headers,
    );

    verificar(resposta, [200]);

    final List dados = jsonDecode(resposta.body);
    return dados.map((e) => Item.fromJson(e)).toList();
  }

  static Future<Item> buscarItem(int id) async {
    final resposta = await http.get(
      Uri.parse('$baseUrl/itens/$id'),
      headers: headers,
    );

    verificar(resposta, [200]);
    return Item.fromJson(jsonDecode(resposta.body));
  }

  static Future<void> criarItem(Map<String, dynamic> dados) async {
    final resposta = await http.post(
      Uri.parse('$baseUrl/itens'),
      headers: headers,
      body: jsonEncode(dados),
    );

    verificar(resposta, [201]);
  }

  static Future<void> editarItem(int id, Map<String, dynamic> dados) async {
    final resposta = await http.put(
      Uri.parse('$baseUrl/itens/$id'),
      headers: headers,
      body: jsonEncode(dados),
    );

    verificar(resposta, [200]);
  }

  static Future<void> excluirItem(int id) async {
    final resposta = await http.delete(
      Uri.parse('$baseUrl/itens/$id'),
      headers: headers,
    );

    verificar(resposta, [204]);
  }

  // CATEGORIAS
  static Future<List<dynamic>> listarCategorias() async {
    final resposta = await http.get(
      Uri.parse('$baseUrl/categorias'),
      headers: headers,
    );

    verificar(resposta, [200]);
    return jsonDecode(resposta.body);
  }
}
