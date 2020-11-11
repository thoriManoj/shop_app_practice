import 'package:flutter/material.dart';
import 'package:shop_app_practice/models/cart.dart';
import 'package:shop_app_practice/provider/order.dart';
import 'package:shop_app_practice/provider/product_provider.dart';
import 'package:shop_app_practice/screens/cart_item_screen.dart';
import 'package:shop_app_practice/screens/edit_product_screen.dart';
import 'package:shop_app_practice/screens/orders_screen.dart';
import 'package:shop_app_practice/screens/product_detail_screen.dart';
import 'package:shop_app_practice/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_practice/screens/user_product_screen.dart';
import 'package:shop_app_practice/widgets/order_design.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => ProductProvider()),
        ChangeNotifierProvider(
          create: (BuildContext context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Order(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          primaryColor: Colors.deepOrange,
          accentColor: Colors.amberAccent,
          canvasColor: Colors.white,
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).canvasColor,
                ),
              ),
        ),
        initialRoute: '/',
        routes: {
          '/' : (context) => ProductOverviewScreen(),
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartItemScreen.routeName : (context) => CartItemScreen(),
          OrdersScreen.routeName : (context) => OrdersScreen(),
          UserProductScreen.routeName : (context) => UserProductScreen(),
          EditProductScreen.routeName : (context) => EditProductScreen(),
        },
        //home: ProductOverviewScreen(),
      ),
    );
  }
}
