import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_details%20screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ProductDetailScreen(productsData.id)));
          },
          child: Image.network(
            productsData.imageURL,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            productsData.title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: productsData.togglefav,
            icon: Icon(productsData.isFavourite
                ? Icons.favorite
                : Icons.favorite_outline),
            color: Theme.of(context).accentColor,
          ),
          trailing: Consumer<Cart>(
            builder: (_, cc, __) => IconButton(
              onPressed: () {
                cc.addItem(
                    productsData.id, productsData.title, productsData.price);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Item added to cart !",
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      cc.removeLast(productsData.id);
                    },
                  ),
                ));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
