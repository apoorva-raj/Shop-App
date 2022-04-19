import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String description;
  final String imageURL;
  final category_tags=[];
  bool isFavourite = false;
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imageURL,
    category_tags,
    isFavourite,
  });
  void togglefav() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
