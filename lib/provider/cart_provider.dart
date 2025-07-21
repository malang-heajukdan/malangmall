import 'package:flutter/material.dart';

import '../models/item.dart'; // Item 모델 가져오기

class CartItem {
  final Item item;
  int quantity;

  CartItem({required this.item, required this.quantity});
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Item item, int quantity) {
    // 동일한 ID의 상품이 이미 장바구니에 있는지 확인
    final index = _cartItems.indexWhere((e) => e.item.id == item.id);
    if (index == -1) {
      _cartItems.add(CartItem(item: item, quantity: quantity));
    } else {
      // 이미 있으면 수량 증가 로직이 필요할 경우 여기에 추가
      _cartItems[index].quantity += quantity;
    }
    notifyListeners();
  }

// 아래 코드는 id 에 의존하는 방식이라 id가 중복되지만 않으면 가장 유연하고 메모리 로드가 덜함!
  void removeFromCart(String id) {
    _cartItems.removeWhere((e) => e.item.id == id);
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    final index = _cartItems.indexWhere((e) => e.item.id == id);
    if (index != -1) {
      if (_cartItems[index].quantity >= 1) {
        _cartItems[index].quantity = quantity;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  double get totalPrice =>
      _cartItems.fold(0, (sum, e) => sum + (e.item.price * e.quantity));

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
