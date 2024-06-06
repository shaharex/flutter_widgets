import 'package:flutter/material.dart';

class AnimatedSwitcherExample extends StatelessWidget {
  const AnimatedSwitcherExample({
    super.key,
    required this.toggle,
    required this.duration,
  });
  final bool toggle;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: child,
        );
      },
      child: toggle
          ? Container(
              key: const ValueKey(0),
              height: 50,
              width: 50,
              color: Colors.blue[800],
            )
          : Container(
              key: const ValueKey(1),
              height: 150,
              width: 150,
              color: Colors.red[800],
            ),
    );
  }
}
