import 'package:first_app/product_data.dart';
import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import '../product_card.dart';
import '../data/product_data.dart';
import 'package:first_app/data/product_data.dart';

class NeerConnectHome extends StatefulWidget {
  @override
  _NeerConnectHomeState createState() => _NeerConnectHomeState();
}

class _NeerConnectHomeState extends State<NeerConnectHome> {
  Map<String, int> cartItems = {};

  void _addToCart(String productName) {
    setState(() {
      cartItems.update(productName, (value) => value + 1, ifAbsent: () => 1);
    });
  }

  void _showCartPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems: cartItems, products: products),
      ),
    );
  }

  void _showProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neer Connect"),
        leading: IconButton(icon: Icon(Icons.person), onPressed: _showProfilePage),
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: _showCartPage),
        ],
      ),
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            addToCart: _addToCart,
          );
        },
      ),
    );
  }
}