import 'package:flutter/foundation.dart';
import 'package:shop_app_practice/models/product.dart';

class ProductProvider with ChangeNotifier {
  final _productItems = dummyProducts;

  List<Product> get getItems {
    return [..._productItems];
  }

  List<Product> get favoritesOnly {
    return _productItems.where((prod) => prod.isFavorite).toList();
  }

  Product findByID(String id) {
    return _productItems.firstWhere((prd) => prd.id == id);
  }

  void addProduct(Product product) {
    var newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
    );
    _productItems.add(newProduct);
    notifyListeners();
  }
  void updateProduct(String id,Product product) {
    final prodIndex = _productItems.indexWhere((prod) => prod.id == id);
    if(prodIndex >= 0) {
      _productItems[prodIndex] = product;
      notifyListeners();
    } else {
      print("...");
    }
  }
}
