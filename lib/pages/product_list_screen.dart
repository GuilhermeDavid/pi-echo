import 'package:pi/entities/product.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  final List<Product> products;

  const ProductListScreen({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          final product = products[index];
          return ListTile(
            leading: Image.network(product.image),
            title: Text(product.title),
            subtitle: Text(product.description),
            trailing: Text('\$${product.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}