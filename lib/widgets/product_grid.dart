import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_practice/provider/product_provider.dart';
import 'package:shop_app_practice/widgets/product_item.dart';

class ProductGrid extends StatelessWidget {

  final bool isOnlyFavorites;
  ProductGrid(this.isOnlyFavorites);

  @override
  Widget build(BuildContext context) {
    final productItems = Provider.of<ProductProvider>(context);
    final products = isOnlyFavorites ? productItems.favoritesOnly : productItems.getItems;
    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
      itemCount: products.length,
    );
  }
}
