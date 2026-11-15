import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/routes/app_router.dart';
import '../core/utils/validators.dart';
import '../core/theme/app_theme.dart';
import '../services/api_service.dart';

class ItemFormScreen extends StatefulWidget {
  final int? itemId;

  const ItemFormScreen({super.key, this.itemId});

  @override
  State<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final formulario = GlobalKey<FormState>();
  final nome = TextEditingController();
  final estoque = TextEditingController();

  List<dynamic> categorias = [];
  int? categoriaId;
  bool salvando = false;
  late Future<void> carregamento;

  bool get editando => widget.itemId != null;

  @override
  void initState() {
    super.initState();
    carregamento = carregar();
  }

  Future<void> carregar() async {
    categorias = await ApiService.listarCategorias();

    if (editando) {
      final item = await ApiService.buscarItem(widget.itemId!);
      nome.text = item.nome;
      estoque.text = item.quantidadeEstoque.toString();
      categoriaId = item.categoriaId;
    }
  }

  Future<void> salvar() async {
    if (!formulario.currentState!.validate()) return;

    setState(() => salvando = true);

    final dados = {
      'nome': nome.text.trim(),
      'quantidade_estoque': int.parse(estoque.text),
      'categoria_id': categoriaId,
    };

    try {
      if (editando) {
        await ApiService.editarItem(widget.itemId!, dados);
      } else {
        await ApiService.criarItem(dados);
      }

      if (!mounted) return;
      context.goNamed(AppRouter.itens);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
    } finally {
      if (mounted) setState(() => salvando = false);
    }
  }

  @override
  void dispose() {
    nome.dispose();
    estoque.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? 'Editar item' : 'Novo item'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(AppRouter.itens),
        ),
      ),
      body: FutureBuilder<void>(
        future: carregamento,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          if (categorias.isEmpty) {
            return const Center(
              child: Text('Nenhuma categoria disponível na API'),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.espacamento),
                child: Form(
                  key: formulario,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: nome,
                        decoration: const InputDecoration(
                          labelText: 'Nome do item',
                          border: OutlineInputBorder(),
                        ),
                        validator: Validators.obrigatorio,
                      ),

                      const SizedBox(height: AppTheme.espacamento),

                      TextFormField(
                        controller: estoque,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantidade em estoque',
                          border: OutlineInputBorder(),
                        ),
                        validator: Validators.estoque,
                      ),

                      const SizedBox(height: AppTheme.espacamento),

                      DropdownButtonFormField<int>(
                        initialValue: categoriaId,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Categoria',
                          border: OutlineInputBorder(),
                        ),
                        items: categorias.map<DropdownMenuItem<int>>((
                          categoria,
                        ) {
                          return DropdownMenuItem<int>(
                            value: categoria['id'] as int,
                            child: Text(
                              categoria['nome'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (valor) => categoriaId = valor,
                        validator: (valor) =>
                            valor == null ? 'Selecione uma categoria' : null,
                      ),

                      const SizedBox(height: AppTheme.espacamento),

                      ElevatedButton(
                        onPressed: salvando ? null : salvar,
                        child: salvando
                            ? const CircularProgressIndicator()
                            : Text(
                                editando
                                    ? 'Salvar alterações'
                                    : 'Cadastrar item',
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
