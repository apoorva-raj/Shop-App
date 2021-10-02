import 'package:flutter/material.dart';
import 'package:shop_app/screens/4.1%20auth_screen.dart';
import '../screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../providers/auth.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: MaterialApp(
        home: AuthScreen(),
        theme: ThemeData(
          accentColor: Colors.deepOrange,
          primaryColor: Colors.purple,
          fontFamily: 'Lato',
        ),
      ),
    );
  }
}
