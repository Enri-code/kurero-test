import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurero_test/features/chat/domain/entities/message.dart';
import 'package:kurero_test/features/profile/bloc/profile_bloc.dart';

class TextLayout extends StatelessWidget {
  const TextLayout({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        message.data,
        style: TextStyle(
            color: context.watch<ProfileBloc>().state.user.id == message.senderId
                ? Colors.white
                : Colors.black),
      ),
    );
  }
}
