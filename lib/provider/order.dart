import 'package:flutter/material.dart';
import 'package:shop_app_practice/models/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime orderDate;

  OrderItem(this.id, this.amount, this.products, this.orderDate);
}

class Order with ChangeNotifier {
  List<OrderItem> _orderItems = [];

  List<OrderItem> get orderItems {
    return [..._orderItems];
  }

  void addOrders(List<CartItem> cartProducts, double total) {
    _orderItems.insert(
      0,
      OrderItem(
        DateTime.now().toString(),
        total,
        cartProducts,
        DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
