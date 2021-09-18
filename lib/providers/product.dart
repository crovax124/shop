import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.description,
    @required this.imageUrl,
    @required this.title,
    @required this.price,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    final url = Uri.https(
        'shopapp-2b6a2-default-rtdb.europe-west1.firebasedatabase.app',
        '/products/$id.json');

    _setFavValue(!isFavorite);

    try {
      final response = await http.patch(
        url,
        body: jsonEncode(
          {'isFavorite': isFavorite},
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
      HttpException('didnt happen');
    }
  }
}
