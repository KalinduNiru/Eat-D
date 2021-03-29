import 'package:flutter/material.dart';

class HomeListItem extends StatelessWidget {
  final Widget child;
  final Animation animation;

  const HomeListItem({Key key, this.child, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: SizedBox(
        child: child,
      ),
    );
  }
}
