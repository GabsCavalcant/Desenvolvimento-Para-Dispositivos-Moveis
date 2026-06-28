import 'package:flutter/material.dart';

void main() {
  print("Numeros de 1 a 100:");

  for (int i = 1; i <= 100; i++) {
    print(i);
  }

  print("\nNumeros pares:");

  for (int i = 2; i <= 100; i += 2) {
    print(i);
  }
}