import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/product_model.dart';

// product deatils page
// 1. show the product  data
// 2. get the list of cart items
// 3. add product to the list of cart items
// 4. be able to show it on cart page

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Box<List<dynamic>> cartBox;
  List<Product> currentCart = [];
  List<Map<dynamic, dynamic>> currentCartItems = [];

  void getCartItems() {
    final cartItems = cartBox.get("cartList", defaultValue: [{"title": 'gogo'}]);
    debugPrint(cartItems.toString());

    // 2. get the list of cart items
    for (var product in cartItems!) {
      currentCartItems.add(product);
    }
    debugPrint(currentCartItems.toString());
  }

  void addToCart(Product product) {
    final productMap = product.toMap();
    currentCartItems.add(productMap);
    setState(() {
      cartBox.put("cartList", currentCartItems);
    });
  }

  @override
  void initState() {
    cartBox = Hive.box('cartB');
    getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. show the product  data
            Text(
              widget.product.title,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => addToCart(widget.product),
                child: const Text("Add to cart")),
          ],
        ),
      ),
    );
  }
}
