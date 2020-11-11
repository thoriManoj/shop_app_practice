import 'package:flutter/material.dart';
import 'package:shop_app_practice/provider/order.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderDesign extends StatefulWidget {
  final OrderItem orderItem;

  OrderDesign(this.orderItem);

  @override
  _OrderDesignState createState() => _OrderDesignState();
}

class _OrderDesignState extends State<OrderDesign> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 5.0,
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${widget.orderItem.amount}',
              style: TextStyle(fontSize: 16.0),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy - hh:mm')
                  .format(widget.orderItem.orderDate),
            ),
            trailing: IconButton(
              icon:
                  _expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 4.0),
              height: min(widget.orderItem.products.length * 20.0 + 100, 100),
              child: ListView(
                children: widget.orderItem.products.map(
                  (prod) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        prod.title,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${prod.quantity} x \$${prod.price}',
                        style: TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
