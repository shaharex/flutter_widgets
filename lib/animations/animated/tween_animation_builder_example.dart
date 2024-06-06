import 'package:flutter/material.dart';

class TweenAnimationBuilderExample extends StatefulWidget {
  const TweenAnimationBuilderExample({super.key, required this.toggle});
  final bool toggle;

  @override
  State<TweenAnimationBuilderExample> createState() =>
      _TweenAnimationBuilderExampleState();
}

class _TweenAnimationBuilderExampleState
    extends State<TweenAnimationBuilderExample> {
  @override
  Widget build(BuildContext context) {
    final _forwardTween = ColorTween(begin: Colors.white, end: Colors.red);
    final _reverseTween = ReverseTween(_forwardTween);

    return TweenAnimationBuilder(
      tween: widget.toggle ? _forwardTween : _reverseTween,
      duration: Duration(seconds: 2),
      builder: (_, Color? color, __) {
        return ColorFiltered(
          colorFilter: ColorFilter.mode(color!, BlendMode.modulate),
          child: Image.asset('/sun.jpg'),
        );
      },
    );

    // return TweenAnimationBuilder(
    //     tween: Tween(
    //       begin: toggle ? 0.0 : 1.0,
    //       end: toggle ? 1.0 : 0.0,
    //     ),
    //     duration: duration,
    //     builder: (context, value, child) {
    //       return Opacity(
    //           opacity: value,
    //           child: SizedBox(
    //             width: 200 * value,
    //             height: 200 * value,
    //             child: Container(
    //               color: const Color.fromARGB(0, 12, 12, 162),
    //             ),
    //           ));
    //     });
  }
}
