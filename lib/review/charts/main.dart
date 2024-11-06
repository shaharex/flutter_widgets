import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ChartPage()));
}

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final random = Random();
  int dataset = 50;

  void changeData() {
    setState(() {
      dataset = random.nextInt(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: Size(200, 100),
          painter: BarChartPainter(dataset.toDouble()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeData,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
static const barWidth = 10.0;

BarChartPainter(this.barHeight);

final double barHeight;

@override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = Colors.blue.shade400
    ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH((size.width - barWidth), size.height - barHeight, barWidth, barHeight), paint);
    
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}