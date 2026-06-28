import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'dados.dart';

class Rotas {
  Router get router {
    final router = Router();

    // GET /produtos
    router.get('/produtos', (Request req) {
      return Response.ok(
        jsonEncode(produtos),
        headers: {'Content-Type': 'application/json'},
      );
    });

    // POST /adicionar
    router.post('/adicionar', (Request req) async {
      final body = await req.readAsString();
      final data = jsonDecode(body);

      final novo = {
        "id": produtos.length + 1,
        "nome": data["nome"],
        "preco": data["preco"],
      };

      produtos.add(novo);

      return Response.ok(
        jsonEncode({
          "mensagem": "Produto adicionado",
          "produto": novo
        }),
        headers: {'Content-Type': 'application/json'},
      );
    });

    return router;
  }
}