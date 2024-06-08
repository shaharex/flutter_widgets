import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final Duration duration = Duration(seconds: 3);

class MyTransitionedAnimation extends StatefulWidget {
  const MyTransitionedAnimation({super.key});

  @override
  State<MyTransitionedAnimation> createState() =>
      _MyTransitionedAnimationState();
}

class _MyTransitionedAnimationState extends State<MyTransitionedAnimation>
    with SingleTickerProviderStateMixin {
  // with SingleTickerProviderStateMixin we get access to ticker, which helps to recognize the frames per smth
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    // with this, animationcontroller knows when the frames will change can listen it
    _controller = AnimationController(vsync: this, duration: duration)
      ..addListener(() {
        print(_controller.status);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // FloatingActionButton(
            //   onPressed: () {
            //     setState(() {
            //       _controller.reverse();
            //       // stop(canceled: true) future will stop
            //       // _controller.stop();
            //       // _controller.reset();
            //       // if (_controller.isCompleted) {
            //       //   _controller.reverse();
            //       // } else {
            //       //   _controller.forward();
            //       // }
            //     });
            //   },
            //   child: const Icon(
            //     Icons.pause,
            //     color: Colors.black,
            //   ),
            // ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.forward();
                  // _controller.animateTo(0.5);
                  // _controller.animateBack(0.5);
                  // _controller.fling(
                  //   velocity: 1.0,
                  //   springDescription: SpringDescription.withDampingRatio(
                  //     mass: 5,
                  //     stiffness: 500.0,
                  //     ratio: 3,
                  //   ),
                  // );
                  // _controller.repeat(reverse: true);
                });
              },
              child: const Icon(
                Icons.play_arrow,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Center(
            child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(40),
          child: StaggeredAnimationFromLazy(controller: _controller),
        )),
      ),
    );
  }
}

class ScaleTransitionExample extends StatelessWidget {
  const ScaleTransitionExample({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          child: child,
          scale: controller.value,
        );
      },
      child: Container(
        width: 100,
        height: 200,
        color: Colors.red,
      ),
    );
    // return ScaleTransition(
    //   scale: controller,
    //   child: FadeTransition(
    //     opacity: controller,
    //     child: Container(
    //       width: 100,
    //       height: 200,
    //       color: Colors.red,
    //     ),
    //   ),
    // );
  }
}

class AnimatedWidgetExample extends AnimatedWidget {
  const AnimatedWidgetExample({required AnimationController controller})
      : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.scale(
      scale: animation.value,
      child: Container(
        width: 100,
        height: 200,
        color: Colors.red,
      ),
    );
  }
}

class StaggeredAnimationFromLazy extends StatelessWidget {
  const StaggeredAnimationFromLazy({
    super.key,
    required this.controller,
  });

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: MyIconPainter(controller),
          size: const Size(300, 300),
        );
      },
    );
  }
}

class MyIconPainter extends CustomPainter {
  final AnimationController controller;

  late final Animation<double> dotGrow;
  late final Animation<double> lineGrow;
  late final Animation<double> linesMove;

  MyIconPainter(this.controller) {
    dotGrow = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.25, curve: Curves.easeOut),
    ));
    lineGrow = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.25, 0.55, curve: Curves.easeIn),
    ));
    linesMove = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.55, 1.00, curve: Curves.bounceOut),
    ));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final dotPainter = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    final linesPainter = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 40;

    canvas.drawCircle(
      Offset(centerX, centerY),
      20.0 * dotGrow.value,
      dotPainter,
    );

    if (dotGrow.value < 1.0) return;
    canvas.drawLine(
      Offset(
        centerX - centerX * linesMove.value,
        centerY - centerY * lineGrow.value,
      ),
      Offset(
        centerX + centerX * linesMove.value,
        centerY + centerY * lineGrow.value,
      ),
      linesPainter,
    );
    canvas.drawLine(
      Offset(
        centerX + centerX * linesMove.value,
        centerY - centerY * lineGrow.value,
      ),
      Offset(
        centerX - centerX * linesMove.value,
        centerY + centerY * lineGrow.value,
      ),
      linesPainter,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
