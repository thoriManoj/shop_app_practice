import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_practice/provider/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail-screen';

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<ProductProvider>(context).findByID(productID);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 2.0,
              margin: EdgeInsets.all(10.0),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              '\$${product.price}',
              style: TextStyle(
                  fontSize: 25.0, color: Theme.of(context).primaryColor),
            ),
            SizedBox(height : 10.0),
            Text(
              product.description,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            )
          ],
        ),
      ),
    );
  }
}
