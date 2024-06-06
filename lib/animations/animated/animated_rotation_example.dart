import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedRotationExample extends StatelessWidget {
  const AnimatedRotationExample({
    Key? key,
    required this.toggle,
    required this.duration,
  }) : super(key: key);
  final bool toggle;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      duration: duration,
      turns: toggle ? 0 : pi,
      child: AnimatedContainer(
        duration: duration,
        decoration: BoxDecoration(
          borderRadius:
              toggle ? BorderRadius.circular(40) : BorderRadius.circular(0),
          color: Colors.red[800],
          border: Border.all(
            width: 1.5,
            color: toggle
                ? const Color.fromARGB(255, 235, 213, 23)
                : const Color.fromARGB(255, 127, 239, 254),
          ),
        ),
        height: toggle ? 70 : 50,
        width: toggle ? 70 : 50,
      ),
    );
  }
}
