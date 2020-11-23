import 'package:flutter/material.dart';
import 'package:shop_app_practice/provider/auth.dart';
import 'package:shop_app_practice/screens/orders_screen.dart';
import 'package:shop_app_practice/screens/product_overview_screen.dart';
import 'package:shop_app_practice/screens/user_product_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            //padding: EdgeInsets.only(top: 25.0),
            height: 100,
            child: Center(
              child: Text(
                'Shop Owl',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text(
              'Shop',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ProductOverviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text(
              'Your Orders',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            onTap: () {
              Navigator.of(context).popAndPushNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'Your Products',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            onTap: () {
              Navigator.of(context).popAndPushNamed(UserProductScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context,listen: false).logout();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
