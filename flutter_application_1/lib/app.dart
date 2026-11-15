import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/pedidos_screen.dart';
import 'screens/pedido_form_screen.dart';
import 'screens/itens_screen.dart';
import 'screens/item_form_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.criar(
      telaLogin: const LoginScreen(),
      telaInicio: const HomeScreen(),
      telaPedidos: const PedidosScreen(),
      telaNovoPedido: const PedidoFormScreen(),
      telaEditarPedido: (id) => PedidoFormScreen(pedidoId: id),
      telaItens: const ItensScreen(),
      telaNovoItem: const ItemFormScreen(),
      telaEditarItem: (id) => ItemFormScreen(itemId: id),
    );

    return MaterialApp.router(
      title: AppConstants.nomeApp,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.tema,
      routerConfig: router,
    );
  }
}
