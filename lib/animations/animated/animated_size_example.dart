import 'package:flutter/material.dart';

class AnimatedSizeExample extends StatelessWidget {
  const AnimatedSizeExample({
    Key? key,
    required this.toggle,
    required this.duration,
  }) : super(key: key);
  final bool toggle;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      child: Container(
        height: 50,
        width: 50,
        color: Colors.amber[900],
      ),
    );
  }
}
