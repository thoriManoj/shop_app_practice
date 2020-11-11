import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_practice/models/cart.dart';

class CartItemDesign extends StatelessWidget {
  final String id;
  final String productID;
  final String title;
  final double price;
  final int quantity;

  CartItemDesign(
      this.id, this.productID, this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      confirmDismiss: (direction) {
        return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (ctx) => AlertDialog(
            elevation: 5.0,
            title: Text('Are You Sure?'),
            content: Text('Do you want to remove item from cart?'),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
      background: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).errorColor,
            borderRadius: BorderRadius.circular(15.0)),
        child: Icon(
          Icons.delete,
          size: 40.0,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        item.removeItem(productID);
      },
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.all(5.0),
            child: FittedBox(
              child: CircleAvatar(
                maxRadius: 25.0,
                child: Text('\$$price'),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('\$${(price * quantity)}'),
          trailing: Text(
            '$quantity x',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
