import 'package:flutter/material.dart';
import 'package:kurero_test/features/chat/presentation/widgets/chat_boxes/shared/chat_box.dart';

class ReceiverChatBoxBase extends StatelessWidget {
  const ReceiverChatBoxBase({
    Key? key,
    required this.child,
    required this.time,
    this.padding = 5,
  }) : super(key: key);

  final double padding;
  final Widget child;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Row(
                children: [
                  ChatBoxBase(
                    color: Colors.white,
                    padding: padding,
                    child: child,
                  ),
                ],
            ),
          ),
          const SizedBox(height: 4),
          Text(time, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
