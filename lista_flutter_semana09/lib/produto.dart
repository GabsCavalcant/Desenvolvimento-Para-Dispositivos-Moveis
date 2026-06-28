class Produto {
  String? id;
  String nome;
  double preco;
  int quantidade;

  Produto({
    this.id,
    required this.nome,
    required this.preco,
    required this.quantidade,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'preco': preco,
      'quantidade': quantidade,
    };
  }

  factory Produto.fromMap(String id, Map<dynamic, dynamic> map) {
    return Produto(
      id: id,
      nome: map['nome'] ?? '',
      preco: (map['preco'] ?? 0).toDouble(),
      quantidade: (map['quantidade'] ?? 0).toInt(),
    );
  }
}