import 'package:flutter/material.dart';

class AnimatedContainerExample extends StatelessWidget {
  const AnimatedContainerExample({
    Key? key,
    required this.toggle,
    required this.duration,
  }) : super(key: key);
  final bool toggle;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.linear,
      duration: duration,
      color: toggle ? Colors.red : Colors.green,
      padding: toggle ? const EdgeInsets.all(40) : const EdgeInsets.all(80),
      width: toggle ? 100 : 400,
      child: Container(
        width: 50,
        height: 50,
        color: Colors.blue,
      ),
      onEnd: () {
        print('hello');
      },
    );
  }
}
