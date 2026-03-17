import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier{
  final List<Product> _cart=[];
  List<Product> get cart=>_cart;
  int get itemCount => _cart.length;
  double get totalPrice {
    double total=0;
    for(var item in  _cart){
      total+=item.price;
    }
    return total;
  }
  void addToCart(Product product){
    _cart.add(product);
    notifyListeners();
  }
  void removeFromCart(Product product){
    _cart.remove(product);
    notifyListeners();
  }
 }
