import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const login = 'login';
  static const inicio = 'inicio';
  static const pedidos = 'pedidos';
  static const novoPedido = 'novoPedido';
  static const editarPedido = 'editarPedido';
  static const itens = 'itens';
  static const novoItem = 'novoItem';
  static const editarItem = 'editarItem';

  static GoRouter criar({
    required Widget telaLogin,
    required Widget telaInicio,
    required Widget telaPedidos,
    required Widget telaNovoPedido,
    required Widget Function(int) telaEditarPedido,
    required Widget telaItens,
    required Widget telaNovoItem,
    required Widget Function(int) telaEditarItem,
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
        GoRoute(
          path: '/pedidos/:id/editar',
          name: editarPedido,
          builder: (context, state) =>
              telaEditarPedido(int.parse(state.pathParameters['id']!)),
        ),
        GoRoute(
          path: '/itens',
          name: itens,
          builder: (context, state) => telaItens,
        ),
        GoRoute(
          path: '/itens/novo',
          name: novoItem,
          builder: (context, state) => telaNovoItem,
        ),
        GoRoute(
          path: '/itens/:id/editar',
          name: editarItem,
          builder: (context, state) =>
              telaEditarItem(int.parse(state.pathParameters['id']!)),
        ),
      ],
    );
  }
}
