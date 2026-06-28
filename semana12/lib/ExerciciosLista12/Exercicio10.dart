Future<String> buscarDados() async {
  await Future.delayed(Duration(seconds: 3));

  return "Dados carregados com sucesso";
}

Future<void> main() async {
  String resultado = await buscarDados();

  print(resultado);
}