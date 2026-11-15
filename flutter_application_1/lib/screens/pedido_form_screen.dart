import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/routes/app_router.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/validators.dart';
import '../models/item.dart';
import '../services/api_service.dart';

class PedidoFormScreen extends StatefulWidget {
  final int? pedidoId;

  const PedidoFormScreen({super.key, this.pedidoId});

  @override
  State<PedidoFormScreen> createState() => _PedidoFormScreenState();
}

class _PedidoFormScreenState extends State<PedidoFormScreen> {
  final formulario = GlobalKey<FormState>();

  final nomeCliente = TextEditingController();
  final telefone = TextEditingController();
  final quantidade = TextEditingController();
  final endereco = TextEditingController();

  List<Item> itens = [];
  int? itemId;
  int? clienteId;
  DateTime? prazo;

  bool salvando = false;
  late Future<void> carregamento;

  bool get editando => widget.pedidoId != null;

  @override
  void initState() {
    super.initState();
    carregamento = carregar();
  }

  Future<void> carregar() async {
    itens = await ApiService.listarItens();

    if (editando) {
      final pedido = await ApiService.buscarPedido(widget.pedidoId!);
      final cliente = await ApiService.buscarCliente(pedido.clienteId);

      clienteId = pedido.clienteId;
      nomeCliente.text = cliente['nome'];
      telefone.text = cliente['telefone'];
      itemId = pedido.itemId;
      quantidade.text = pedido.quantidade.toString();
      endereco.text = pedido.enderecoEntrega;
      prazo = DateTime.parse(pedido.prazoEntrega);
    }
  }

  Future<void> escolherData() async {
    final agora = DateTime.now();
    final hoje = DateTime(agora.year, agora.month, agora.day);

    final data = await showDatePicker(
      context: context,
      initialDate: prazo != null && !prazo!.isBefore(hoje) ? prazo! : hoje,
      firstDate: hoje,
      lastDate: DateTime(2035),
    );

    if (data != null) {
      setState(() => prazo = data);
    }
  }

  Future<void> salvar() async {
    if (!formulario.currentState!.validate()) return;

    if (prazo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione o prazo de entrega')),
      );
      return;
    }

    final agora = DateTime.now();
    final hoje = DateTime(agora.year, agora.month, agora.day);

    if (prazo!.isBefore(hoje)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um prazo válido')),
      );
      return;
    }

    setState(() => salvando = true);

    try {
      if (editando) {
        await ApiService.editarCliente(
          clienteId!,
          nomeCliente.text.trim(),
          telefone.text.trim(),
        );
      } else {
        // Cliente cadastrado automaticamente.
        final cliente = await ApiService.criarCliente(
          nomeCliente.text.trim(),
          telefone.text.trim(),
        );

        clienteId = cliente['id'] as int;
      }

      final dados = {
        'cliente_id': clienteId,
        'item_id': itemId,
        'quantidade': int.parse(quantidade.text),
        'endereco_entrega': endereco.text.trim(),
        'prazo_entrega': prazo!.toIso8601String().split('T').first,
      };

      if (editando) {
        await ApiService.editarPedido(widget.pedidoId!, dados);
      } else {
        await ApiService.criarPedido(dados);
      }

      if (!mounted) return;
      context.goNamed(AppRouter.pedidos);
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
    nomeCliente.dispose();
    telefone.dispose();
    quantidade.dispose();
    endereco.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? 'Editar pedido' : 'Novo pedido'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(AppRouter.pedidos),
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

          if (itens.isEmpty) {
            return const Center(
              child: Text('Cadastre um item antes de criar pedidos'),
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
                        controller: nomeCliente,
                        decoration: const InputDecoration(
                          labelText: 'Nome do cliente',
                          border: OutlineInputBorder(),
                        ),
                        validator: Validators.obrigatorio,
                      ),

                      const SizedBox(height: AppTheme.espacamento),

                      TextFormField(
                        controller: telefone,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Telefone do cliente',
                          border: OutlineInputBorder(),
                        ),
                        validator: Validators.telefone,
                      ),

                      const SizedBox(height: AppTheme.espacamento),

                      DropdownButtonFormField<int>(
                        initialValue: itemId,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Item',
                          border: OutlineInputBorder(),
                        ),
                        items: itens.map((item) {
                          return DropdownMenuItem<int>(
                            value: item.id,
                            child: Text(
                              item.nome,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (valor) => itemId = valor,
                        validator: (valor) =>
                            valor == null ? 'Selecione um item' : null,
                      ),

                      const SizedBox(height: AppTheme.espacamento),

                      TextFormField(
                        controller: quantidade,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantidade',
                          border: OutlineInputBorder(),
                        ),
                        validator: Validators.quantidade,
                      ),

                      const SizedBox(height: AppTheme.espacamento),

                      TextFormField(
                        controller: endereco,
                        decoration: const InputDecoration(
                          labelText: 'Endereço de entrega',
                          border: OutlineInputBorder(),
                        ),
                        validator: Validators.obrigatorio,
                      ),

                      const SizedBox(height: AppTheme.espacamento),

                      OutlinedButton.icon(
                        onPressed: escolherData,
                        icon: const Icon(Icons.calendar_month),
                        label: Text(
                          prazo == null
                              ? 'Selecionar prazo de entrega'
                              : 'Prazo: ${prazo!.day}/${prazo!.month}/${prazo!.year}',
                        ),
                      ),

                      const SizedBox(height: AppTheme.espacamento),

                      ElevatedButton(
                        onPressed: salvando ? null : salvar,
                        child: salvando
                            ? const CircularProgressIndicator()
                            : Text(
                                editando ? 'Salvar alterações' : 'Criar pedido',
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
