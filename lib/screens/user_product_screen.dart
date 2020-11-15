import 'package:flutter/material.dart';
import 'package:shop_app_practice/provider/product_provider.dart';
import 'package:shop_app_practice/screens/edit_product_screen.dart';
import 'package:shop_app_practice/widgets/AppDrawer.dart';
import 'package:shop_app_practice/widgets/user_product_design.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatefulWidget {
  static const routeName = '/user-product-screen';
  @override
  _UserProductScreenState createState() => _UserProductScreenState();
}

class _UserProductScreenState extends State<UserProductScreen> {

  Future<void> _fetchProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context,listen: false).fetchAndSetData();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _fetchProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (context, index) => UserProductDesign(
                productData.getItems[index].id,
                productData.getItems[index].title,
                productData.getItems[index].imageUrl),
            itemCount: productData.getItems.length,
          ),
        ),
      ),
    );
  }
}
