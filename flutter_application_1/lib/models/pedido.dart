class Pedido {
  final int id;
  final int clienteId;
  final int itemId;
  final int quantidade;
  final String enderecoEntrega;
  final String prazoEntrega;
  final String status;
  final String nomeCliente;
  final String nomeItem;

  Pedido({
    required this.id,
    required this.clienteId,
    required this.itemId,
    required this.quantidade,
    required this.enderecoEntrega,
    required this.prazoEntrega,
    required this.status,
    required this.nomeCliente,
    required this.nomeItem,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      clienteId: json['cliente_id'],
      itemId: json['item_id'],
      quantidade: json['quantidade'],
      enderecoEntrega: json['endereco_entrega'],
      prazoEntrega: json['prazo_entrega'],
      status: json['status'],
      nomeCliente: json['cliente']?['nome'] ?? 'Sem cliente',
      nomeItem: json['item']?['nome'] ?? 'Sem produto',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cliente_id': clienteId,
      'item_id': itemId,
      'quantidade': quantidade,
      'endereco_entrega': enderecoEntrega,
      'prazo_entrega': prazoEntrega,
    };
  }
}
