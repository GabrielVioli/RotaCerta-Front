import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_constants.dart';
import '../core/routes/app_router.dart';
import '../core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.nomeApp)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.espacamento),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.local_shipping, size: 64),

                const SizedBox(height: AppTheme.espacamento),

                Text(
                  'Bem-vindo ao RotaCerta',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(height: 32),

                ElevatedButton.icon(
                  onPressed: () => context.goNamed(AppRouter.pedidos),
                  icon: const Icon(Icons.receipt_long),
                  label: const Text('Gerenciar pedidos'),
                ),

                const SizedBox(height: AppTheme.espacamento),

                ElevatedButton.icon(
                  onPressed: () => context.goNamed(AppRouter.itens),
                  icon: const Icon(Icons.inventory_2),
                  label: const Text('Gerenciar itens'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
