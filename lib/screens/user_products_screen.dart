import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/EditProductsScreen.dart';
import 'package:shop_app/widgets/userProductsItem.dart';
import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  //const UserProductsScreen({ Key? key }) : super(key: key);

  Future<void> refresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchandget();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => EditProductsScreen()));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => refresh(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (_, i) => Column(children: [
              UserProductsItem(
                  productsData.items[i].title, productsData.items[i].imageURL),
              Divider(),
            ]),
            itemCount: productsData.items.length,
          ),
        ),
      ),
    );
  }
}
