import 'package:flutter/material.dart';

class ChatBoxBase extends StatelessWidget {
  const ChatBoxBase({
    Key? key,
    required this.child,
    required this.color,
    this.heightScale = 1,
    this.padding = 12,
  }) : super(key: key);

  final double heightScale;
  final double padding;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10 * heightScale),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            height: 1.3 * heightScale,
            fontSize: 16 * heightScale,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10 * heightScale),
            child: child,
          ),
        ),
      ),
    );
  }
}
