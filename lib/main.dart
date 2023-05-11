import 'package:flutter/material.dart';

import 'package:pi/pages/login_page.dart';
import 'package:pi/pages/product_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: ProductListScreen(),
    );
  }
}
