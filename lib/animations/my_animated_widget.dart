// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'animated/animated.dart';

class MyAnimatedWidget extends StatefulWidget {
  const MyAnimatedWidget({super.key});

  @override
  State<MyAnimatedWidget> createState() => _MyAnimatedWidgetState();
}

class _MyAnimatedWidgetState extends State<MyAnimatedWidget>
    with TickerProviderStateMixin {
  final duration = const Duration(milliseconds: 2000);
  bool toggle = true;

  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        toggle = !toggle;
      });
    });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
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
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(
              () {
                toggle = !toggle;
                if (toggle) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
              },
            );
          },
          child: AnimatedIcon(
            color: Colors.black,
            icon: AnimatedIcons.play_pause,
            progress: _animationController,
          ),
        ),
        body: Center(
          child: AnimatedContainer(
            duration: duration,
            curve: Curves.easeInOut,
            padding:
                toggle ? const EdgeInsets.all(60) : const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius:
                  toggle ? BorderRadius.circular(0) : BorderRadius.circular(70),
            ),
            child: Column(
              // don't use const here if you use the animations wouldn't work
              mainAxisSize: MainAxisSize.min,
              children: [
                // AnimatedContainerExample(toggle: toggle, duration: duration),
                // AnimatedCrossFadeExample(toggle: toggle, duration: duration),
                // AnimatedSizeExample(toggle: toggle, duration: duration),
                AnimatedRotationExample(toggle: toggle, duration: duration),
                // AnimatedSwitcherExample(toggle: toggle, duration: duration),
                // AnimatedIconExample(toggle: toggle, duration: duration),
                // AnimatedOpacityExample(toggle: toggle, duration: duration),
                // TweenAnimationBuilderExample(toggle: toggle),
                // Expanded(child: AnimatedListExample()),
                // AnimatedLogoOfFlutter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
