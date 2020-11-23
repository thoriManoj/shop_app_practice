import 'package:flutter/material.dart';
import 'package:shop_app_practice/models/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime orderDate;

  OrderItem({this.id, this.amount, this.products, this.orderDate});
}

class Order with ChangeNotifier {
  List<OrderItem> _orderItems = [];
  final String authToken;
  final String userId;

  Order(this.authToken, this.userId ,this._orderItems);

  List<OrderItem> get orderItems {
    return [..._orderItems];
  }

  Future<void> addOrders(List<CartItem> cartProducts, double total) async {
    final date = DateTime.now();
    final url =
        'https://shop-app-a7fbd.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'date': date.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    print(json.decode(response.body));
    _orderItems.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        orderDate: date,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    final url =
        'https://shop-app-a7fbd.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print(extractedData);
    if (extractedData == null) {
      return;
    }
    print(extractedData);
    extractedData.forEach(
      (orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            orderDate: DateTime.parse(orderData['date']),
            products: (orderData['products'] as List<dynamic>)
                    ?.map(
                      (e) => CartItem(
                        id: e['id'],
                        price: e['price'],
                        quantity: e['quantity'],
                        title: e['title'],
                      ),
                    )
                    ?.toList() ??
                [],
          ),
          // OrderItem(
          //   id: orderId,
          //   amount: orderData['amount'],
          //   orderDate: DateTime.parse(orderData['date']),
          //   products: (orderData['products'] as List<dynamic>)
          //       .map(
          //         (item) => CartItem(
          //       id: item['id'],
          //       price: item['price'],
          //       quantity: item['quantity'],
          //       title: item['title'],
          //     ),
          //   )
          //       .toList(),
          // ),
        );
      },
    );
    _orderItems = loadedOrders.reversed.toList();
    notifyListeners();
  }

// Future<void> fetchOrders() async {
//   final url = 'https://shop-app-a7fbd.firebaseio.com/orders.json';
//   final response = await http.get(url);
//   print(json.decode(response.body));
//   final existingOrders = json.decode(response.body) as Map<String, dynamic>;
//   final List<OrderItem> loadOrders = [];
//   if(existingOrders == null) {
//     return;
//   }
//   existingOrders.forEach((orderID, order) {
//     loadOrders.add(
//       OrderItem(
//         id: orderID,
//         amount: order['amount'],
//         orderDate: DateTime.parse(order['date']),
//         products: (order['product'] as List<dynamic>).map(
//           (item) => CartItem(
//             id: item['id'],
//             price: item['price'],
//             quantity: item['quantity'],
//             title: item['title'],
//           ),
//         ).toList(),
//       ),
//     );
//   });
//   _orderItems = loadOrders.reversed.toList();
//   notifyListeners();
// }
}
