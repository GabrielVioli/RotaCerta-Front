import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/routes/app_router.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/validators.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formulario = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool carregando = false;
  String? erro;

  Future<void> entrar() async {
    if (!formulario.currentState!.validate()) {
      return;
    }

    setState(() {
      carregando = true;
      erro = null;
    });

    try {
      final sucesso = await ApiService.login(email.text.trim(), senha.text);

      if (!mounted) return;

      if (sucesso) {
        context.goNamed(AppRouter.inicio);
      } else {
        setState(() {
          erro = 'E-mail ou senha incorretos';
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        erro = 'Não foi possível conectar à API';
      });
    } finally {
      if (mounted) {
        setState(() {
          carregando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    email.dispose();
    senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.espacamento),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: formulario,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_shipping, size: 70),
                  const SizedBox(height: AppTheme.espacamento),

                  Text(
                    'RotaCerta',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),

                  const SizedBox(height: 32),

                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                    validator: Validators.email,
                  ),

                  const SizedBox(height: AppTheme.espacamento),

                  TextFormField(
                    controller: senha,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                    validator: Validators.senha,
                  ),

                  const SizedBox(height: AppTheme.espacamento),

                  if (erro != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        erro!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: carregando ? null : entrar,
                      child: carregando
                          ? const CircularProgressIndicator()
                          : const Text('Entrar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
