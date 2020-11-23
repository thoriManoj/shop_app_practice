import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app_practice/models/http_exception.dart';
import 'package:shop_app_practice/models/product.dart';

class ProductProvider with ChangeNotifier {
  //final _productItems = []; //dummyProducts;
  List<Product> _productItems = [];
  final String authToken;
  final String userId;

  ProductProvider(this.authToken, this.userId, this._productItems);

  List<Product> get getItems {
    return [..._productItems];
  }

  List<Product> get favoritesOnly {
    return _productItems.where((prod) => prod.isFavorite).toList();
  }

  Product findByID(String id) {
    return _productItems.firstWhere((prd) => prd.id == id);
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://shop-app-a7fbd.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId,
        }),
      );
      print(json.decode(response.body));
      var newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
      );
      _productItems.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetData([bool filterByUser = false]) async {

    String filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://shop-app-a7fbd.firebaseio.com/products.json?auth=$authToken&$filterString';

    final response = await http.get(url);
    final List<Product> loadedProduct = [];
    final extractedProduct = json.decode(response.body) as Map<String, dynamic>;
    if (extractedProduct == null) {
      return;
    }
    url =
        'https://shop-app-a7fbd.firebaseio.com/usersFavotites/$userId.json?auth=$authToken';
    final favoriteResponse = await http.get(url);
    final favoriteData = json.decode(favoriteResponse.body);
    extractedProduct.forEach((prodId, product) {
      loadedProduct.add(Product(
        id: prodId,
        title: product['title'],
        description: product['description'],
        imageUrl: product['imageUrl'],
        price: product['price'],
        isFavorite:
            favoriteData == null ? false : favoriteData[prodId] ?? false,
      ));
    });
    _productItems = loadedProduct;
    notifyListeners();
  }

  Future<void> updateProduct(String id, Product product) async {
    final prodIndex = _productItems.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://shop-app-a7fbd.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
          }));
      _productItems[prodIndex] = product;
      notifyListeners();
    } else {
      print("...");
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://shop-app-a7fbd.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex =
        _productItems.indexWhere((element) => (element.id == id));
    var existingProduct = _productItems[existingProductIndex];
    _productItems.removeAt(existingProductIndex);
    notifyListeners();
    final value = await http.delete(url);
    if (value.statusCode >= 400) {
      _productItems.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not Delete the Item!');
    }
    existingProduct = null;
  }
}
