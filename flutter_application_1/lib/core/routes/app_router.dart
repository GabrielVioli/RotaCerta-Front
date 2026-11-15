import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const login = 'login';
  static const inicio = 'inicio';
  static const pedidos = 'pedidos';
  static const novoPedido = 'novoPedido';

  static GoRouter criar({
    required Widget telaLogin,
    required Widget telaInicio,
    required Widget telaPedidos,
    required Widget telaNovoPedido,
  }) {
    return GoRouter(
      routes: [
        GoRoute(path: '/', name: login, builder: (context, state) => telaLogin),
        GoRoute(
          path: '/inicio',
          name: inicio,
          builder: (context, state) => telaInicio,
        ),
        GoRoute(
          path: '/pedidos',
          name: pedidos,
          builder: (context, state) => telaPedidos,
        ),
        GoRoute(
          path: '/pedidos/novo',
          name: novoPedido,
          builder: (context, state) => telaNovoPedido,
        ),
      ],
    );
  }
}
