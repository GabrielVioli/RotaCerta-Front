import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_constants.dart';
import '../core/routes/app_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.login)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed(AppRouter.inicio),
          child: const Text(AppConstants.entrar),
        ),
      ),
    );
  }
}
