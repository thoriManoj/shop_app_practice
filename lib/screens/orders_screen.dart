import 'package:flutter/material.dart';
import 'package:shop_app_practice/provider/order.dart';
import 'package:shop_app_practice/provider/product_provider.dart';
import 'package:shop_app_practice/widgets/AppDrawer.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_practice/widgets/order_design.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order-screen';

//   @override
//   _OrdersScreenState createState() => _OrdersScreenState();
// }
//
// class _OrdersScreenState extends State<OrdersScreen> {
//   Future _orderFuture;
//   var _isInit = true;
//   var _isLoading = false;
//
//   Future _orderFutureState() {
//     return Provider.of<Order>(context, listen: false).fetchOrders();
//   }
//
//   @override
//   void initState() {
//     _orderFuture = _orderFutureState();
//     super.initState();
//   }

  // @override
  // void didChangeDependencies() {
  //   if(_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Provider.of<Order>(context,listen: false).fetchOrders().then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    //final orders = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Order>(context, listen: false).fetchOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // ...
              throw dataSnapshot.error;
              // Do error handling stuff
              // return Center(
              //   child: Text('An error occurred!'),
              // );
            } else {
              return Consumer<Order>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orderItems.length,
                  itemBuilder: (ctx, i) => OrderDesign(orderData.orderItems[i]),
                ),
              );
            }
          }
        },
      ),
      // body: FutureBuilder(
      //   future: Provider.of<Order>(context, listen: false).fetchOrders(),
      //   builder: (ctx, dataSnapshot) {
      //     if (dataSnapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else {
      //       if (dataSnapshot.error != null) {
      //         // ...
      //         throw dataSnapshot.error;
      //         // Do error handling stuff
      //         // return Center(
      //         //   child: Text(dataSnapshot.error),
      //         // );
      //       } else {
      //         return Consumer<Order>(
      //           builder: (ctx, orderData, child) => ListView.builder(
      //             itemCount: orderData.orderItems.length,
      //             itemBuilder: (ctx, i) => OrderDesign(orderData.orderItems[i]),
      //           ),
      //         );
      //       }
      //     }
      //   },
      // ),


      // body: FutureBuilder(
      //   future: _orderFuture,
      //   builder: (context, dataSnapShot) {
      //     if (dataSnapShot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else {
      //       if (dataSnapShot.error != null) {
      //         print(dataSnapShot.toString());
      //         throw dataSnapShot.error.toString();
      //         // return Center(
      //         //   child: Text(dataSnapShot.error.toString()),
      //         // );
      //       } else {
      //         return Consumer<Order>(
      //           builder: (context, orderData, child) => Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: ListView.builder(
      //               itemBuilder: (context, index) => OrderDesign(
      //                 orders.orderItems[index],
      //               ),
      //               itemCount: orders.orderItems.length,
      //             ),
      //           ),
      //         );
      //       }
      //     }
      //   },
      // ),
      // body: _isLoading
      //     ? Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ListView.builder(
      //           itemBuilder: (context, index) => OrderDesign(
      //             orders.orderItems[index],
      //           ),
      //           itemCount: orders.orderItems.length,
      //         ),
      //       ),
    );
  }
}
