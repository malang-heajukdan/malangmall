import 'package:flutter/material.dart';
import '../models/item.dart'; // Item 모델 가져오기

class CartProvider with ChangeNotifier {
  final List<Item> _cartItems = [];

  List<Item> get cartItems => _cartItems;

  void addToCart(Item item) {
    // 동일한 ID의 상품이 이미 장바구니에 있는지 확인
    final index = _cartItems.indexWhere((e) => e.id == item.id);
    if (index == -1) {
      _cartItems.add(item);
    } else {
      // 이미 있으면 수량 증가 로직이 필요할 경우 여기에 추가
      _cartItems[index].quantity += 1;
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _cartItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void decreaseQuantity(String id) {
    final index = _cartItems.indexWhere((e) => e.id == id);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity -= 1;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  double get totalPrice =>
      _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
