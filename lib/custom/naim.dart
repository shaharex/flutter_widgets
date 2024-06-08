import 'package:counter_50/custom/custom_paint.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyCustomApp());
}

class MyCustomApp extends StatelessWidget {
  const MyCustomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Example(),
      ),
    );
  }
}
