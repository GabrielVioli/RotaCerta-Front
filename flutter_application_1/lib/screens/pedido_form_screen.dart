import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_constants.dart';
import '../core/routes/app_router.dart';

class PedidoFormScreen extends StatelessWidget {
  const PedidoFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.novoPedido),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(AppRouter.pedidos),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed(AppRouter.pedidos),
          child: const Text(AppConstants.voltar),
        ),
      ),
    );
  }
}
