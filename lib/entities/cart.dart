import 'package:flutter/material.dart';
import 'package:pi/pages/login_page.dart';
import 'package:pi/entities/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Cart {
  final List<Product> _items = [];
  List<Product> itemsCart = [];

  List<Product> get items => _items;

  Future<void> add(Product product) async {
    _items.add(product);
    final url = Uri.parse('http://localhost:3000/cart');

    final data = {
      'userId': 1,
      'productId': product.id,
      'quantidade': 1,
      'productName': product.title,
      'price': product.price
    };

    final headers = {'Content-Type': 'application/json'};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 201) {
      print('Item adicionado com sucesso!');
    } else {
      print(
          'Erro ao adicionar ao carrinho. Código de status: ${response.statusCode}');
    }
  }

  void remove(Product product) {
    final index = _items.indexOf(product);
    if (index >= 0) {
      _items.removeAt(index);
    }
  }

  Future<void> fetchCartItems() async {
    final url = Uri.parse('http://localhost:3000/cart');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      itemsCart =
          List<Product>.from(jsonData.map((item) => Product.fromJson(item)));
    } else {
      print(
          'Erro ao buscar itens do carrinho. Código de status: ${response.statusCode}');
    }
  }

  Future<void> finalizarCompra(List<Product> items) async {
    if (items.isEmpty) {
      print("No products");
      return;
    }

    final url = Uri.parse('http://localhost:3000/sale');

    final itemsMap = items
        .map((product) => {
              'productId': product.id,
              'quantidade': 1,
              'productName': product.title,
              "price": product.price
            })
        .toList();

    final data = {
      'userId': 1,
      'data': DateTime.now().toIso8601String(),
      'produtos': itemsMap,
    };

    final headers = {'Content-Type': 'application/json'};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 201) {
      print('Compra finalizada com sucesso!');
      items.clear();
    } else {
      print(
          'Erro ao finalizar a compra. Código de status: ${response.statusCode}');
    }
  }

  double get total => _items.fold(0, (sum, item) => sum + item.price);
}
