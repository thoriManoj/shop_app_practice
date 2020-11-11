import 'package:flutter/material.dart';
import 'package:shop_app_practice/provider/order.dart';
import 'package:shop_app_practice/widgets/AppDrawer.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_practice/widgets/order_design.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order-screen';

 // final String

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(itemBuilder: (context,index) => OrderDesign(
        orders.orderItems[index],
      ),
        itemCount: orders.orderItems.length,),
    );
  }
}


