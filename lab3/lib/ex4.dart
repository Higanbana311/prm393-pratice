import 'dart:async';

void main(){
  Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  Stream<int> squareStream = numberStream.map((number) => number * number);
  
  Stream<int> evenStream = squareStream.where((square) => square % 2 == 0);

  evenStream.listen((evenSquare) {
    print('Even square: $evenSquare');
  });

}