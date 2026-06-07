import 'dart:async';

class Product{
  final int id;
  final String name;
  final int price;
  Product(this.id, this.name, this.price);

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price}';
  }
}

class ProductRepository{
  final List<Product> _listProduct = [
      Product(1, 'Laptop', 1000),
      Product(2, 'Smartphone', 500),
      Product(3, 'Tablet', 300),
    ];
  

  final StreamController<Product> _productStreamController = StreamController<Product>.broadcast();

  Future<List<Product>> getAll(){
    return Future.value(_listProduct);
  }

  Stream<Product> liveAdd(){
    return _productStreamController.stream;
  }

  void addProduct(Product product){
    _listProduct.add(product);
    _productStreamController.add(product);
  }
}

void main(){
  final productRepository = ProductRepository();

  productRepository.getAll().then((products) {
    print('Products: $products');
  });

  productRepository.liveAdd().listen((product) {
    print('New product added: $product');
  });

  productRepository.addProduct(Product(4, 'Headphones', 150));
}

