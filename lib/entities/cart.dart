import 'package:pi/entities/product.dart';

class Cart {
  final List<Product> _items = [];

  List<Product> get items => _items;

  void add(Product product) {
    _items.add(product);
  }

  void remove(Product product) {
    final index = _items.indexOf(product);
    if (index >= 0) {
      _items.removeAt(index);
    }
  }

  double get total => _items.fold(0, (sum, item) => sum + item.price);
}