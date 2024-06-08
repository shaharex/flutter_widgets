import 'dart:math';

import 'package:flutter/material.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
      height: 100,
      width: 100,
      child: RadialPercentWidget(
        percent: 0.24,
        fillColor: Colors.black,
        lineColor: Colors.red,
        freeColor: Colors.yellow,
        widthDouble: 5,
        child: Text(
          '24%',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ));
  }
}

class RadialPercentWidget extends StatelessWidget {
  const RadialPercentWidget({
    super.key,
    required this.child,
    required this.percent,
    required this.fillColor,
    required this.lineColor,
    required this.freeColor,
    required this.widthDouble,
  });
  final Widget child;
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double widthDouble;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: MyPainter(
            percent: percent,
            fillColor: fillColor,
            lineColor: lineColor,
            freeColor: freeColor,
            widthDouble: widthDouble,
          ),
          child: Center(
            child: child,
          ),
        ),
      ],
    );
  }
}

// be careful, extend CustomPainter not CustomPaint
class MyPainter extends CustomPainter {
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double widthDouble;

  MyPainter({
    super.repaint,
    required this.percent,
    required this.fillColor,
    required this.lineColor,
    required this.freeColor,
    required this.widthDouble,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect arcRect = calcuateArcsRect(size);

    drawBackground(canvas, size);
    drawFreeArc(canvas, arcRect);
    drawFilledArc(canvas, arcRect);
  }

  void drawFilledArc(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint.color = lineColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = widthDouble;
    paint.strokeCap = StrokeCap.round;
    canvas.drawArc(
      arcRect,
      -pi / 2,
      // this is the lenght of arc
      pi * 2 * percent,
      false,
      paint,
    );
  }

  void drawFreeArc(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint.color = freeColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = widthDouble;
    canvas.drawArc(
      arcRect,
      pi * 2 * percent - (pi / 2),
      // this is the lenght of arc
      pi * 2 * (1.0 - percent),
      false,
      paint,
    );
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = fillColor;
    paint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect calcuateArcsRect(Size size) {
    const linesMargin = 3;
    final offest = widthDouble / 2 + linesMargin;
    final arcRect = Offset(offest, offest) &
        Size(size.width - offest * 2, size.height - offest * 2);
    return arcRect;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
