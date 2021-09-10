import 'package:flutter/material.dart';

import './product.dart';


class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Rotes Shirt',
      description: 'Ein rotes Shirt - ziemlich Rot!',
      price: 29.99,
      imageUrl:
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Hosen',
      description: 'Eine wirklich schöne Hose',
      price: 59.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Gelber Schal',
      description: 'Warm und gemütlich - am besten für den Winter!.',
      price: 19.99,
      imageUrl:
      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Eine Pfanne',
      description: 'z.B. für Bratwürstchen',
      price: 49.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
// var _showFavoritesOnly = false;

    List<Product> get items {
      // if (_showFavoritesOnly) {
      //   return _items.where((prodItem) => prodItem.isFavorite).toList();
      // }
    return [..._items];
    }

List<Product> get favoriteItems {
      return _items.where((prodItem) => prodItem.isFavorite).toList();
}


    Product findById(String id) {
      return _items.firstWhere((prod) => prod.id == id);
    }
    // void showFavoritesOnly() {

    //   _showFavoritesOnly = true;
    //   notifyListeners();
    // }
    //
    // void showAll() {
    //   _showFavoritesOnly = false;
    //   notifyListeners();
    // }

    void addProduct() {
      notifyListeners();
    }
}