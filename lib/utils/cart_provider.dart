
import 'package:flutter/material.dart';
import 'package:neer_connect/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void addProduct(Product product) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeProduct(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    final existingIndex = _items.indexWhere((item) => item.product.id == productId);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(String productId) {
    final existingIndex = _items.indexWhere((item) => item.product.id == productId);
    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity -= 1;
      } else {
        removeProduct(productId);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items = [];
    notifyListeners();
  }
}