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
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (context) => Products(null, []),
            update: (context, auth, prevProducts) =>
                Products(auth.token, prevProducts!.items)),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          home: auth.isAuth ? ProductsOverViewScreen() : AuthScreen(),
          theme: ThemeData(
            accentColor: Colors.deepOrange,
            primaryColor: Colors.purple,
            fontFamily: 'Lato',
          ),
        ),
      ),
    );
  }
}
