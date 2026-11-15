import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/routes/app_router.dart';
import '../models/pedido.dart';
import '../services/api_service.dart';

class PedidosScreen extends StatefulWidget {
  const PedidosScreen({super.key});

  @override
  State<PedidosScreen> createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  late Future<List<Pedido>> pedidos;

  @override
  void initState() {
    super.initState();
    atualizar();
  }

  void atualizar() {
    setState(() {
      pedidos = ApiService.listarPedidos();
    });
  }

  void mostrarErro(Object erro) {
    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(erro.toString())));
  }

  Future<void> mudarStatus(Pedido pedido, String status) async {
    try {
      await ApiService.alterarStatus(pedido.id, status);
      if (!mounted) return;
      atualizar();
    } catch (e) {
      mostrarErro(e);
    }
  }

  Future<void> excluir(Pedido pedido) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir pedido'),
        content: Text('Deseja excluir o pedido de ${pedido.nomeCliente}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    try {
      await ApiService.excluirPedido(pedido.id);
      if (!mounted) return;
      atualizar();
    } catch (e) {
      mostrarErro(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(AppRouter.inicio),
        ),
        actions: [
          IconButton(onPressed: atualizar, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder<List<Pedido>>(
        future: pedidos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Erro ao carregar pedidos'),
                  TextButton(
                    onPressed: atualizar,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          final lista = snapshot.data ?? [];

          if (lista.isEmpty) {
            return const Center(child: Text('Nenhum pedido encontrado'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final pedido = lista[index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(pedido.nomeCliente),
                        subtitle: Text(
                          '${pedido.nomeItem}\n'
                          'Quantidade: ${pedido.quantidade}\n'
                          'Endereço: ${pedido.enderecoEntrega}\n'
                          'Prazo: ${pedido.prazoEntrega}',
                        ),
                        isThreeLine: true,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Status: ${pedido.status}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            tooltip: 'Editar',
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              context.goNamed(
                                AppRouter.editarPedido,
                                pathParameters: {'id': pedido.id.toString()},
                              );
                            },
                          ),

                          PopupMenuButton<String>(
                            tooltip: 'Alterar status',
                            icon: const Icon(Icons.more_horiz),
                            onSelected: (status) {
                              mudarStatus(pedido, status);
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'pendente',
                                child: Text('Pendente'),
                              ),
                              const PopupMenuItem(
                                value: 'entregue',
                                child: Text('Entregue'),
                              ),
                              const PopupMenuItem(
                                value: 'cancelado',
                                child: Text('Cancelado'),
                              ),
                            ],
                          ),

                          IconButton(
                            tooltip: 'Excluir',
                            icon: const Icon(Icons.delete),
                            onPressed: () => excluir(pedido),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(AppRouter.novoPedido),
        child: const Icon(Icons.add),
      ),
    );
  }
}
