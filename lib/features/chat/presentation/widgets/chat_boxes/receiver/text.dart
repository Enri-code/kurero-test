import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurero_test/features/chat/domain/entities/message.dart';
import 'package:kurero_test/features/chat/presentation/chat_bloc/chat_bloc.dart';
import 'package:kurero_test/features/chat/presentation/widgets/chat_boxes/receiver_box_bas.dart';
import 'package:kurero_test/features/chat/presentation/widgets/chat_boxes/shared/text_layout.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReceiverChatText extends StatelessWidget {
  const ReceiverChatText(this.message, {Key? key}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return ReceiverChatBoxBase(
      time: timeago.format(message.timeSent!, locale: 'en_short'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '~ ${context.watch<GroupChatBloc>().getUserFromId(message.senderId).name}',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextLayout(message: message),
        ],
      ),
    );
  }
}
