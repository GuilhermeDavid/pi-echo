import 'dart:convert';

import 'package:pi/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pi/pages/Cart_screen.dart';
import 'package:pi/entities/cart.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final Cart cart;

  const ProductDetailsScreen(
      {Key? key, required this.product, required this.cart})
      : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        backgroundColor: Color(0xFFE3762B), // Cor do AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartScreen(cart: widget.cart)),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFF2E2CE), // Cor do fundo
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                widget.product.image,
                width: MediaQuery.of(context).size.width *
                    0.5, // Diminuindo a largura da imagem em 50%
              ),
              SizedBox(height: 16),
              Text(
                widget.product.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF18171D), // Cor do título
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Preço: \$${widget.product.price}',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF38221F), // Cor do preço
                ),
              ),
              SizedBox(height: 16),
              Card(
                color: Color(0xFFE3762B),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0), // Cor da descrição
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  widget.cart.add(widget.product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Produto adicionado ao carrinho!'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF703F2A), // Cor do botão
                ),
                child: Text('Adicionar ao carrinho'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
