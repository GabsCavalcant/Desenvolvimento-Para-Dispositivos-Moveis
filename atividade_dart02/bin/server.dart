import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

import '../lib/rotas.dart';

void main() async {
  final rotas = Rotas();

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(rotas.router.call);

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);

  print('Servidor rodando em http://localhost:${server.port}');
}