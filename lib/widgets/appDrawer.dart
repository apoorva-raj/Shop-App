import 'package:flutter/material.dart';
import 'package:shop_app/screens/Order_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Your space"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ProductsOverViewScreen()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Your Products"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => UserProductsScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
