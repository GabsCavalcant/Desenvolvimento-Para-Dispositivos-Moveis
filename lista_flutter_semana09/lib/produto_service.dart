import 'package:firebase_database/firebase_database.dart';
import 'produto.dart';

class ProdutoService {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref('produtos');

  // CREATE
  Future<void> adicionar(Produto produto) async {
    await _ref.push().set(produto.toMap());
  }

  // READ
  Stream<List<Produto>> listar() {
    return _ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return [];

      final map = Map<String, dynamic>.from(data as Map);
      return map.entries
          .map((e) => Produto.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
          .toList();
    });
  }

  // UPDATE
  Future<void> atualizar(Produto produto) async {
    await _ref.child(produto.id!).update(produto.toMap());
  }

  // DELETE
  Future<void> deletar(String id) async {
    await _ref.child(id).remove();
  }
}