import 'package:flutter/material.dart';

void main(){
  double calculaArea(double base, double altura) {
    return (base * altura) / 2;
  }
  double area = calculaArea(10,5);

  print("Área do triângulo: $area");

}

