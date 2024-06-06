import 'package:flutter/material.dart';

// first you need StatefulWidget
class AnimatedListExample extends StatefulWidget {
  const AnimatedListExample({super.key});

  @override
  State<AnimatedListExample> createState() => _AnimatedListExampleState();
}

class _AnimatedListExampleState extends State<AnimatedListExample> {
  // second: you need Key
  final _listKey = GlobalKey<AnimatedListState>();
  // the list is not changing, it is the same list and the adding and removing methods also same,
  // you don't need to change them, only use animation after modification of list
  var _data = [1, 2, 3, 4];

  // fifth: add methods for adding and removing
  void _insert() {
    final element = (_data.isEmpty ? 0 : _data.last) + 1;
    _data.add(element);
    // IMPORTANT: first adding the element to the list, and only after animations
    // use appropriate index

    final index = _data.length - 1;
    _listKey.currentState?.insertItem(index);
  }

  void _removeAtIndex(int index) {
    final element = _data.removeAt(index);

    _listKey.currentState?.removeItem(index, (context, animation) {
      return SlideTransition(
          // types are not same,so it won't work because of the type so use drive()
          position: animation.drive(Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: const Offset(0.0, 0.0),
          )),
          child: _RowWidget(text: element));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _insert,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
          child: AnimatedList(
        // third AnimatedList, use key above
        key: _listKey,
        initialItemCount: _data.length,
        itemBuilder: (context, index, animation) {
          // fourth use of animation
          return SizeTransition(
            sizeFactor: animation,
            child: GestureDetector(
              onTap: () => _removeAtIndex(index),
              child: _RowWidget(
                text: _data[index],
              ),
            ),
          );
        },
      )),
    );
  }
}

class _RowWidget extends StatelessWidget {
  const _RowWidget({
    super.key,
    required this.text,
  });

  final int text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text('$text'),
        ),
      ),
    );
  }
}
