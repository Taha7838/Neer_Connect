// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:neer_connect/models/product_model.dart';
import 'package:neer_connect/screens/cart.dart';
import 'package:neer_connect/screens/order_history.dart';
import 'package:neer_connect/utils/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> products = [
    Product(
      id: 'normal',
      name: 'Normal Water',
      description: 'Pure RO filtered room temperature water',
      price: 20.0,
      imageUrl: 'assets/normal_water.png',
    ),
    Product(
      id: 'cold',
      name: 'Cold Water',
      description: 'Refreshing chilled RO filtered water',
      price: 25.0,
      imageUrl: 'assets/cold_water.png',
    ),
    Product(
      id: 'hot',
      name: 'Hot Water',
      description: 'Steaming hot RO filtered water',
      price: 30.0,
      imageUrl: 'assets/hot_water.png',
    ),
    Product(
      id: 'ice',
      name: 'Ice Cubes',
      description: 'Crystal clear ice cubes made from RO water',
      price: 15.0,
      imageUrl: 'assets/ice_cubes.png',
    ),
  ];

  ProductsPage({super.key});

  void _showQuantityDialog(BuildContext context, Product product) {
    int quantity = 1;
    
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Select Quantity'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(product.name),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: quantity > 1
                          ? () => setState(() => quantity -= 1)
                          : null,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '$quantity',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => setState(() => quantity += 1),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Total: ₹${(product.price * quantity).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  _addToCart(context, product, quantity);
                },
                child: Text('ADD TO CART'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _addToCart(BuildContext context, Product product, int quantity) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    for (int i = 0; i < quantity; i++) {
      cartProvider.addProduct(product);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${quantity}x ${product.name} added to cart'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'VIEW CART',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(userId: 'user'), // Keeping userId empty to match your existing code
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String username = args['username'] ?? '';
    final String userId = args['userId'] ?? '';
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome $username'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(userId: userId),
                    ),
                  );
                },
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartProvider.itemCount}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select Water Type',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: products.map((product) => _buildProductCard(context, product)).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tap Add to Cart to select quantity.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderHistoryPage(userId: userId),
                ),
              );
            },
            child: Text("View Order History"),
          ),
            ],
          )
          
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Container(
                height: 150,
                width: double.infinity,
                color: Colors.blue.shade100,
                child: Icon(
                  _getIconForProduct(product.id),
                  size: 80,
                  color: Colors.blue.shade700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₹${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showQuantityDialog(context, product),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForProduct(String id) {
    switch (id) {
      case 'normal': return Icons.water_drop_outlined;
      case 'cold': return Icons.ac_unit;
      case 'hot': return Icons.local_fire_department;
      case 'ice': return Icons.grid_4x4;
      default: return Icons.water;
    }
  }
}
