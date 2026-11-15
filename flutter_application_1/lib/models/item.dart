class Item {
  final int id;
  final String nome;
  final int quantidadeEstoque;
  final int categoriaId;

  Item({
    required this.id,
    required this.nome,
    required this.quantidadeEstoque,
    required this.categoriaId,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      nome: json['nome'],
      quantidadeEstoque: json['quantidade_estoque'],
      categoriaId: json['categoria_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'quantidade_estoque': quantidadeEstoque,
      'categoria_id': categoriaId,
    };
  }
}
