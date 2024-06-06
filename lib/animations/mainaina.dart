import 'package:counter_50/animations/animated/animated_list_example.dart';
import 'package:counter_50/animations/my_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.blue[900],
        systemNavigationBarColor: Colors.blue[600]),
  );
  runApp(const MyAnimatedApp());
}

class MyAnimatedApp extends StatelessWidget {
  const MyAnimatedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAnimatedWidget(),
    );
  }
}
