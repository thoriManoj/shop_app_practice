import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_practice/models/cart.dart';
import 'package:shop_app_practice/models/product.dart';
import 'package:shop_app_practice/screens/product_detail_screen.dart';

class ProductItem extends StatefulWidget {
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final productItems = Provider.of<Product>(context, listen: false);
    final cartItem = Provider.of<Cart>(context, listen: false);
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: productItems.id,
          );
        },
        child: Image.network(
          productItems.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black45,
        leading: Consumer<Product>(
          builder: (context, product, child) => IconButton(
            icon: Icon(
              productItems.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () => productItems.toggleFavoriteStatus(),
          ),
        ),
        title: Text(
          productItems.title,
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            cartItem.addItems(
              productItems.id,
              productItems.title,
              productItems.price,
            );
            Scaffold.of(context).removeCurrentSnackBar();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                elevation: 5.0,
                content: Text('Item Added To Cart!'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cartItem.removeSingleItem(productItems.id);
                  },
                ),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
      ),
    );
  }
}
