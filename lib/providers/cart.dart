import 'package:flutter/foundation.dart';

class CartItem {
  String id;
  double price;
  int quantity;
  String title;
  CartItem(
    this.id,
    this.price,
    this.quantity,
    this.title,
  );
}

class Cart with ChangeNotifier {
  // ignore: prefer_final_fields
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  // ignore: non_constant_identifier_names
  int get tota_items => items.length;
  // ignore: non_constant_identifier_names
  double get total_amount {
    double total = 0;
    items.forEach((key, value) {
      CartItem temp = value;
      total += temp.price * temp.quantity;
    });
    return total;
  }

  void addItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
          id, (value) => CartItem(id, price, value.quantity + 1, title));
    } else {
      _items.putIfAbsent(id, () => CartItem(id, price, 1, title));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void removeLast(String id) {
    if (!_items.containsKey(id))
      return;
    else if (_items[id]!.quantity > 1) {
      _items.update(
          id,
          (value) =>
              CartItem(value.id, value.price, value.quantity - 1, value.title));
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }
}
