// ignore_for_file: prefer_const_constructors

import 'package:neer_connect/utils/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CartPage extends StatelessWidget {
  final String userId;
  const CartPage({super.key, required this.userId});

  Future<void> checkout(BuildContext context) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final url = Uri.parse('http://10.0.2.2:5000/checkout'); // Localhost for emulator

    if (cartProvider.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cart is empty!")),
      );
      return;
    }

    // Convert cart items to JSON format
    List<Map<String, dynamic>> cartItems = cartProvider.items.map((cartItem) {
      return {
        "productId": cartItem.product.id,
        "name": cartItem.product.name,
        "quantity": cartItem.quantity,
        "price": cartItem.product.price,
      };
    }).toList();

    final requestBody = jsonEncode({
      "userId": userId,
      "items": cartItems,
      "totalPrice": cartProvider.totalAmount,
    });
    
    print(requestBody);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Show success message and clear the cart
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Checkout'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Processing order for ₹${cartProvider.totalAmount.toStringAsFixed(2)}'),
                SizedBox(height: 20),
                Text(responseData["message"]),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  cartProvider.clear();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData["message"])),
        );
      }
    } catch (error) {
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to process checkout")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartProvider.items.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Your cart is empty',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Continue Shopping'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: cartProvider.items.length,
                    itemBuilder: (ctx, index) {
                      final cartItem = cartProvider.items[index];
                      return Dismissible(
                        key: ValueKey(cartItem.product.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 4,
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        onDismissed: (direction) {
                          cartProvider.removeProduct(cartItem.product.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${cartItem.product.name} removed from cart'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 4,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  _getIconForProduct(cartItem.product.id),
                                  color: Colors.blue.shade700,
                                  size: 30,
                                ),
                              ),
                              title: Text(cartItem.product.name),
                              subtitle: Text(
                                  'Total: ₹${cartItem.totalPrice.toStringAsFixed(2)}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      cartProvider.decreaseQuantity(cartItem.product.id);
                                    },
                                  ),
                                  Text('${cartItem.quantity}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      cartProvider.increaseQuantity(cartItem.product.id);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (cartProvider.items.isNotEmpty)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₹${cartProvider.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => checkout(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  IconData _getIconForProduct(String id) {
    switch (id) {
      case 'normal':
        return Icons.water_drop_outlined;
      case 'cold':
        return Icons.ac_unit;
      case 'hot':
        return Icons.local_fire_department;
      case 'ice':
        return Icons.grid_4x4;
      default:
        return Icons.water;
    }
  }
}
