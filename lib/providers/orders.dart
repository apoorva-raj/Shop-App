import 'package:flutter/foundation.dart';
import './cart.dart';

class OrderItem {
  String id;
  double amount;
  List<CartItem> products;
  DateTime dateTime;
  OrderItem(
      {required this.id,
      required this.products,
      required this.amount,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> item, double price) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            products: item,
            amount: price,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
