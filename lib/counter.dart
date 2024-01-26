import 'package:flutter/material.dart';

void main() {
  runApp(const Counter());
}

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 29, 53),
          title: const Text(
            'Counter',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: const PlusMinus(),
      ),
    );
  }
}

class PlusMinus extends StatefulWidget {
  const PlusMinus({super.key});

  @override
  State<PlusMinus> createState() => _PlusMinus();
}

class _PlusMinus extends State<PlusMinus> {
  int _countfrom = 50;

  void _plusCounter() {
    setState(() {
      _countfrom++;
    });
  }

  void _minusCounter() {
    setState(() {
      _countfrom--;
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: const Color.fromARGB(255, 1, 29, 53),
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      color: Colors.white,
                      onPressed: _minusCounter,
                      icon: const Icon(Icons.remove)),
                  Text(
                    '$_countfrom',
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  IconButton(
                      color: Colors.white,
                      onPressed: _plusCounter,
                      icon: const Icon(Icons.add))
                ],
              ),
            )
          ]),
    );
  }
}
