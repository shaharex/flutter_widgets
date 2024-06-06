import 'package:flutter/material.dart';

class AnimatedCrossFadeExample extends StatelessWidget {
  const AnimatedCrossFadeExample({
    Key? key,
    required this.toggle,
    required this.duration,
  }) : super(key: key);
  final bool toggle;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: duration,
      crossFadeState:
          toggle ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Container(
        color: Colors.red[900],
        height: 100,
        width: 100,
      ),
      secondChild: Container(
        color: Colors.blue[900],
        height: 150,
        width: 150,
      ),
    );
  }
}
