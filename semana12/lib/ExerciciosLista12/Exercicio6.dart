#!/usr/bin/env kotlin

void main() {
  Set<int> numeros = {};

  for (int i = 1; i <= 10; i++) {
    numeros.add(i);
  }

  numeros.add(5);

  print(numeros);
}