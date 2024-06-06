import 'package:flutter/material.dart';

class AnimatedOpacityExample extends StatelessWidget {
  const AnimatedOpacityExample({
    super.key,
    required this.toggle,
    required this.duration,
  });
  final bool toggle;
  final duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      curve: Curves.bounceOut,
      duration: duration,
      opacity: toggle ? 1 : 0,
      child: Container(
        color: Color(0xff239209),
        height: 200,
        width: 200,
      ),
    );
  }
}
