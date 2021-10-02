import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  String id;
  ProductDetailScreen(this.id);
  @override
  Widget build(BuildContext context) {
    final loadedprod =
        Provider.of<Products>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedprod.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
