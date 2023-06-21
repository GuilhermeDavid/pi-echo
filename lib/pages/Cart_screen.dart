import 'dart:html';

import 'package:flutter/material.dart';
import 'package:pi/entities/product.dart';
import 'package:pi/entities/cart.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({Key? key, required this.cart}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    /* _fetchCartItems(); */
  }

  Future<void> _fetchCartItems() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await widget.cart.fetchCartItems();
    } catch (error) {
      print('Erro ao buscar itens do carrinho: $error');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        backgroundColor: Color(0xFFE3762B),
      ),
      backgroundColor: Color(0xFFF2E2CE),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.cart.items.length,
                        itemBuilder: (context, index) {
                          final product = widget.cart.items[index];
                          return ListTile(
                            leading: Image.network(product.image),
                            title: Text(product.title),
                            subtitle: Text('Preço: \$${product.price}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                widget.cart.remove(product);
                              },
                            ),
                          );
                        },
                      ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Total: \$${widget.cart.total}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Color(0xFFE3762B),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                widget.cart.finalizarCompra(widget.cart.items);
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF38221f),
              ),
              child: Text('Finalizar Compra'),
            ),
          ],
        ),
      ),
    );
  }
}
