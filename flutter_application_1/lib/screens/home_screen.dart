import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_constants.dart';
import '../core/routes/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.nomeApp)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed(AppRouter.pedidos),
          child: const Text(AppConstants.verPedidos),
        ),
      ),
    );
  }
}
