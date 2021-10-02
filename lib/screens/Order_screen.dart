import 'package:flutter/material.dart';
import 'package:shop_app/widgets/appDrawer.dart';
import '../providers/orders.dart' as ord;
import 'package:provider/provider.dart';
import '../widgets/orders_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<ord.Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(title: Text("Your Orders")),
      body: ListView.builder(
        itemBuilder: (_, i) => OrderItem(orders[i]),
        itemCount: orders.length,
      ),
      drawer: AppDrawer(),
    );
  }
}
