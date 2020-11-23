import 'package:flutter/material.dart';
import 'package:shop_app_practice/models/cart.dart';
import 'package:shop_app_practice/provider/auth.dart';
import 'package:shop_app_practice/provider/order.dart';
import 'package:shop_app_practice/provider/product_provider.dart';
import 'package:shop_app_practice/screens/SplashScreen.dart';
import 'package:shop_app_practice/screens/auth_screen.dart';
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
        ChangeNotifierProvider(create: (BuildContext context) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          update: (BuildContext context, auth, previousData) => ProductProvider(
            auth.token,
            auth.userId,
            previousData == null ? [] : previousData.getItems,
          ),
          create: null,
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Order>(
          update: (context, auth, previousOrders) => Order(
              auth.token,
              auth.userId,
              previousOrders == null ? [] : previousOrders.orderItems),
          create: null,
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
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
          home: auth.isAuth
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, userResultSnapshot) =>
                      userResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            //'/' : (context) => ProductOverviewScreen(),
            ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            CartItemScreen.routeName: (context) => CartItemScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            UserProductScreen.routeName: (context) => UserProductScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
            ProductOverviewScreen.routeName: (context) =>
                ProductOverviewScreen(),
          },
          //home: ProductOverviewScreen(),
        ),
      ),
    );
  }
}
