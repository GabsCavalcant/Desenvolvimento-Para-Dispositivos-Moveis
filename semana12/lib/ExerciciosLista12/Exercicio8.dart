class Carro {
  String marca;
  String modelo;
  int ano;

  Carro(this.marca, this.modelo, this.ano);

  void exibirDetalhes() {
    print("Marca: $marca");
    print("Modelo: $modelo");
    print("Ano: $ano");
  }
}

void main() {
  Carro carro = Carro("Toyota", "Corolla", 2024);

  carro.exibirDetalhes();
}