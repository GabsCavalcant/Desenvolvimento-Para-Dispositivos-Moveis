import 'package:flutter/material.dart';

void main() {

  void parImpar(int numero){
      if(numero % 2 == 0){
        print("NUMERO PAR");
      }else{
        print("NUMERO IMPAR");
      }
  }
  int numero1 = 9;
  int numero2 = 10;

  parImpar(numero1);
  parImpar(numero2);
}

