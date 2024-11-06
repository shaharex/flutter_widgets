import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Box<List<dynamic>> cartBox;
  List<Map<dynamic, dynamic>> listOfData = [];
  bool isLoading = true;

  getData() {
    final listOfSome = cartBox.get('cartList', defaultValue: [
      {"title": 'gogo'}
    ]);
    debugPrint(listOfSome.toString());
    setState(() {
      for (var product in listOfSome!) {
        listOfData.add(product);
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    cartBox = Hive.box('cartB');
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: ListView.builder(
                itemCount: listOfData.length,
                itemBuilder: (context, index) {
                  final cartItem = listOfData[index];
                  return Container(
                    color: Colors.yellow,
                    child: Text(cartItem['title']),
                  );
                },
              ),
            ),
    );
  }
}
