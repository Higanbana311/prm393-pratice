import 'dart:async';

void main(){
  print("Hello World");

  scheduleMicrotask(() {
    print("Microtask");
  });

  Future(() {
    print("Future");
  });

  print("Goodbye World");
}