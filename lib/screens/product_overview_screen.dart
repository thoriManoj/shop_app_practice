import 'package:flutter/material.dart';
import 'package:shop_app_practice/models/cart.dart';
import 'package:shop_app_practice/provider/product_provider.dart';
import 'package:shop_app_practice/screens/cart_item_screen.dart';
import 'package:shop_app_practice/widgets/AppDrawer.dart';
import 'package:shop_app_practice/widgets/badge.dart';
import 'package:shop_app_practice/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterProduct {
  FAVORITES,
  ALL,
}

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = '/product-overview-screen';
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavoritesOnly = false;
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if(_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context).fetchAndSetData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit= false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Owl'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterProduct productFilter) {
              setState(() {
                if (productFilter == FilterProduct.FAVORITES) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('All Products'),
                value: FilterProduct.ALL,
              ),
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterProduct.FAVORITES,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cartItem, ch) =>
                Badge(child: ch, value: cartItem.itemsCount.toString()),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartItemScreen.routeName);
                }),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(_showFavoritesOnly),
    );
  }
}
