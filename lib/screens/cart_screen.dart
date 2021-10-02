import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart_products = Provider.of<Cart>(context);
    final cart_list = cart_products.items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      cart_products.total_amount.toString(),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart_list.values.toList(),
                          cart_products.total_amount);
                      cart_products.clearCart();
                    },
                    child: Text(
                      "Order Now",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart_list.length,
              itemBuilder: (ctx, i) => Cartitem(
                id: cart_list.values.toList()[i].id,
                price: cart_list.values.toList()[i].price,
                quantity: cart_list.values.toList()[i].quantity,
                title: cart_list.values.toList()[i].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
