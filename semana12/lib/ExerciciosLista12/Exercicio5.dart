void main() {
  List<String> cidades = [
    "São Paulo",
    "Rio de Janeiro",
    "Belo Horizonte",
    "Curitiba",
    "Brasília"
  ];

  print("Lista de cidades:");

  for (int i = 0; i < cidades.length; i++) {
    print(cidades[i]);
  }

  cidades.add("Campinas");

  print("\nLista atualizada:");

  for (int i = 0; i < cidades.length; i++) {
    print(cidades[i]);
  }
}