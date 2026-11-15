import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_constants.dart';
import '../core/routes/app_router.dart';

class PedidosScreen extends StatelessWidget {
  const PedidosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.pedidos),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(AppRouter.inicio),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed(AppRouter.novoPedido),
          child: const Text(AppConstants.adicionarPedido),
        ),
      ),
    );
  }
}
