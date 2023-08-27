import 'package:flutter/material.dart';

class ChatAvatar extends StatelessWidget {
  const ChatAvatar({
    Key? key,
    this.imageUrl,
    this.size = 42,
    this.decoration,
  }) : super(key: key);

  final double? size;
  final String? imageUrl;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    String value = imageUrl ?? '';
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: decoration ??
          BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
          ),
      child: Builder(builder: (context) {
        return Image.network(
          value,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.people_outline, color: Colors.grey[300]),
        );
      }),
    );
  }
}
