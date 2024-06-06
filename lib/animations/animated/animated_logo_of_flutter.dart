import 'package:flutter/material.dart';

class AnimatedLogoOfFlutter extends StatefulWidget {
  const AnimatedLogoOfFlutter({super.key});

  @override
  State<AnimatedLogoOfFlutter> createState() => _AnimatedLogoOfFlutterState();
}

class _AnimatedLogoOfFlutterState extends State<AnimatedLogoOfFlutter>
    with SingleTickerProviderStateMixin {
  late Animation<double> fanimation;
  late AnimationController _fcontroller;

  @override
  void initState() {
    _fcontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    fanimation = Tween<double>(begin: 0, end: 300).animate(_fcontroller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _fcontroller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _fcontroller.forward();
        }
      })
      ..addStatusListener((status) => print('$status'));
    _fcontroller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(animation: fanimation);
  }

  @override
  void dispose() {
    _fcontroller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}
