import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:minimalstore/services/firestore.dart";
import "product.dart";

class Shop extends ChangeNotifier {
  final List<Product> _shop = [];

  List<Product> _cart = [];

  List<Product> get shop => _shop;

  List<Product> get cart => _cart;

  Shop() {
    //Iniciar a escuta dos produtos
    _startProductStream();
  }

  void _startProductStream() {
    FirestoreService().getProductsStream().listen((QuerySnapshot snapshot) {
      _shop.clear();
      for (var data in snapshot.docs) {
        _shop.add(Product(
            name: data['name'],
            description: data['description'],
            price: data['price'],
            imagePath: data['imagepath']));
      }
      notifyListeners();
    });
  }

  //aumentar quantidade de produto no carrinho
  void incrementQuantity(Product item) {
    _cart.firstWhere((cartItem) => cartItem == item).incrementQuantity();
    notifyListeners();
  }

  //diminuir quantidade de produto no carrinho
  void decreamentQuantity(Product item) {
    _cart.firstWhere((cartItem) => cartItem == item).decreamentQuantity();
    notifyListeners();
  }

  //zerar quantidade do produto no carrinho
  void initialQuantity(Product item) {
    _cart.firstWhere((cartItem) => cartItem == item).initialQuantity();
    notifyListeners();
  }

//adicionar produto ao carrinho
  void addToCart(Product item) {
    if (_cart.contains(item)) {
      incrementQuantity(item);
      notifyListeners();
    } else {
      _cart.add(item);
      incrementQuantity(item);
      notifyListeners();
    }
  }

  void removeFromCart(Product item) {
    initialQuantity(item);
    _cart.remove(item);
    notifyListeners();
  }

  void decreamentFromCart(Product item) {
    decreamentQuantity(item);
    notifyListeners();
  }
}
