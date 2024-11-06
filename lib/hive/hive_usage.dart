import 'package:counter_50/hive/cart_page.dart';
import 'package:counter_50/hive/model/product_model.dart';
import 'package:counter_50/hive/product_details_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// products list
// 1. get data from the api
// 2. put data to the hive box
// 3. show the saved data
// 4. search through the local data

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _searchController = TextEditingController();

  late Box<dynamic> box;
  final dio = Dio();

  List<Product> productList = [];
  List<Product> filteredList = [];
  bool isLoading = true;

  void getData() async {
    try {
      // 1.get data from the api
      final response = await dio.get("https://dummyjson.com/products");
      // 2. put data to the hive box
      box.put('productsl', response.data);
      getHiveBox();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Response has errors"),
        ),
      );
      debugPrint(e.toString());
    }
  }

  void getHiveBox() {
    dynamic boxData = box.get('productsl');

    final productModel = ProductModel.fromJson(boxData);
    setState(() {
      productList = productModel.productsList;
      filteredList = productList;
      isLoading = false;
    });
  }

  // 4. search through the local data
  void search(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredList = productList;
      } else {
        filteredList = productList
            .where((product) =>
                product.title.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    box = Hive.box('productsBB');
    getData();
    _searchController.addListener(() {
      search(_searchController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          },
          icon: const Icon(Icons.shopping_cart),
        ),
        title: TextField(
          onChanged: (value) {
            search(value);
          },
          controller: _searchController,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              // 3. show the saved data
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final product = filteredList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsPage(product: product)));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
