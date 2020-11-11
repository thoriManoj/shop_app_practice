import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_practice/models/cart.dart';
import 'package:shop_app_practice/provider/order.dart';
import 'package:shop_app_practice/widgets/cart_item_design.dart';

class CartItemScreen extends StatelessWidget {
  static const routeName = '/cart_item-screen';

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Cart>(context);
    final cart = cartItem.cartItems;
    final order = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 6.0,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Spacer(),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      '\$${cartItem.totalAmount}',
                      style: TextStyle(color: Theme.of(context).primaryTextTheme.headline6.color),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      order.addOrders(cart.values.toList(), cartItem.totalAmount);
                      cartItem.clearCart();
                    },
                    child: Text(
                      'Order Now',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CartItemDesign(
                cartItem.cartItems.values.toList()[index].id,
                cartItem.cartItems.keys.toList()[index],
                cartItem.cartItems.values.toList()[index].title,
                cartItem.cartItems.values.toList()[index].price,
                cartItem.cartItems.values.toList()[index].quantity,
              ),
              // Text(cart.values.toList()[index].title),
              itemCount: cart.length,
            ),
          ),
        ],
      ),
    );
  }
}
