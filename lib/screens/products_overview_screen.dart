import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import '../providers/product.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../providers/cart.dart';
import '../widgets/appDrawer.dart';

class ProductsOverViewScreen extends StatefulWidget {
  // const ProductsOverViewScreen({Key? key}) : super(key: key);
  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  var isInit = true;
  var isLoading = false;
  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
        print("bc");
      });
      Provider.of<Products>(context).fetchandget().then((value) {
        setState(() {
          isLoading = false;
          print("mc");
        });
        print("hemlo");
      });

      print("hello");
    }
    isInit = false;
    super.didChangeDependencies();
  }

  var showOnlyFavourites = false;
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final loadedProducts =
        showOnlyFavourites ? productsData.favitems : productsData.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shop"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (int value) {
              setState(() {
                if (value == 0)
                  showOnlyFavourites = true;
                else
                  showOnlyFavourites = false;
              });
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text("Show Favourites"),
                value: 0,
                onTap: () {
                  //productsData.showfavsonly();
                },
              ),
              PopupMenuItem(
                child: Text("Show All"),
                onTap: () {
                  // productsData.showall();
                },
                value: 1,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartitem, __) => Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => CartScreen()));
                },
              ),
              value: cartitem.tota_items.toString(),
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: loadedProducts[i],
                child: ProductItem(
                    // loadedProducts[i].id,
                    // loadedProducts[i].title,
                    // loadedProducts[i].imageURL,
                    ),
              ),
              padding: const EdgeInsets.all(10),
              itemCount: loadedProducts.length,
            ),
      drawer: AppDrawer(),
    );
  }
}
