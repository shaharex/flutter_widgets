import 'package:flutter/material.dart';

class AnimatedIconExample extends StatefulWidget {
  const AnimatedIconExample({
    super.key,
    required this.toggle,
    required this.duration,
  });
  final bool toggle;
  final duration;

  @override
  State<AnimatedIconExample> createState() => _AnimatedIconExampleState();
}

class _AnimatedIconExampleState extends State<AnimatedIconExample>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();
    animation = Tween<double>(begin: 0, end: 2).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedIcon(
      color: Colors.red[500],
      icon: AnimatedIcons.play_pause,
      progress: _animationController,
    );
  }
}
