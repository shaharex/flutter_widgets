import 'package:counter_50/animations/hero/example_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyHeroApp());
}

class MyHeroApp extends StatelessWidget {
  const MyHeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/': (_) => ExampleWidget1(),
      },
      onGenerateRoute: (_) {
        return PageRouteBuilder(
          pageBuilder: (
            _,
            __,
            ___,
          ) =>
              ExampleWidget2(),
          transitionDuration: Duration(seconds: 4),
        );
      },
    );
  }
}
