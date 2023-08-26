import 'package:flutter/material.dart';

class GroupAvatar extends StatelessWidget {
  const GroupAvatar({
    Key? key,
    this.size = 48,
    this.decoration,
  }) : super(key: key);

  final double? size;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: decoration ??
          BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
          ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Icon(Icons.group_outlined, color: Colors.grey[300]),
        ),
      ),
    );
  }
}
