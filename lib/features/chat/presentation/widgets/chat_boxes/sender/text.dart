import 'package:flutter/material.dart';
import 'package:kureko_test/features/chat/domain/entities/message.dart';
import 'package:kureko_test/features/chat/presentation/widgets/chat_boxes/sender_box_base.dart';
import 'package:kureko_test/features/chat/presentation/widgets/chat_boxes/shared/text_layout.dart';
import 'package:timeago/timeago.dart' as timeago;

class SenderChatText extends StatelessWidget {
  const SenderChatText(this.message, {Key? key}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return SenderChatBoxBase(
      time: timeago.format(message.timeSent!, locale: 'en_short'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextLayout(message: message),
        ],
      ),
    );
  }
}
