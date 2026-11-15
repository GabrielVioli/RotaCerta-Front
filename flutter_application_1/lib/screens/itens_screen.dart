import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/item.dart';
import '../services/api_service.dart';
import '../core/routes/app_router.dart';
import '../core/theme/app_theme.dart';

class ItensScreen extends StatefulWidget {
  const ItensScreen({super.key});

  @override
  State<ItensScreen> createState() => _ItensScreenState();
}

class _ItensScreenState extends State<ItensScreen> {
  late Future<List<Item>> itens;

  @override
  void initState() {
    super.initState();
    atualizar();
  }

  void atualizar() {
    setState(() {
      itens = ApiService.listarItens();
    });
  }

  Future<void> excluir(Item item) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir item'),
        content: Text('Deseja excluir ${item.nome}?'),
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
      await ApiService.excluirItem(item.id);
      if (!mounted) return;
      atualizar();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não foi possível excluir. Verifique se o item possui pedidos.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itens'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(AppRouter.inicio),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: atualizar),
        ],
      ),
      body: FutureBuilder<List<Item>>(
        future: itens,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: TextButton(
                onPressed: atualizar,
                child: const Text('Erro ao carregar. Tentar novamente'),
              ),
            );
          }

          final lista = snapshot.data ?? [];

          if (lista.isEmpty) {
            return const Center(child: Text('Nenhum item cadastrado'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppTheme.espacamento),
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final item = lista[index];

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.inventory_2_outlined),
                  title: Text(item.nome),
                  subtitle: Text('Estoque: ${item.quantidadeEstoque}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => context.goNamed(
                          AppRouter.editarItem,
                          pathParameters: {'id': item.id.toString()},
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => excluir(item),
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
        onPressed: () => context.goNamed(AppRouter.novoItem),
        child: const Icon(Icons.add),
      ),
    );
  }
}
