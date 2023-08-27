import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttering_phrases/fluttering_phrases.dart';
import 'package:kurero_test/features/chat/domain/entities/message.dart';
import 'package:kurero_test/features/chat/domain/entities/user.dart';
import 'package:kurero_test/features/chat/presentation/chat_bloc/chat_bloc.dart';
import 'package:kurero_test/features/chat/presentation/widgets/app_bar_button.dart';
import 'package:kurero_test/features/chat/presentation/widgets/chat_boxes/receiver/text.dart';
import 'package:kurero_test/features/chat/presentation/widgets/chat_boxes/sender/text.dart';
import 'package:kurero_test/features/chat/presentation/widgets/unfocus_bg.dart';
import 'package:kurero_test/features/chat/presentation/widgets/chat_avatar.dart';
import 'package:kurero_test/features/profile/bloc/profile_bloc.dart';

part '../widgets/chat_app_bar.dart';
part '../widgets/input_bar.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Timer? timer;

  @override
  void initState() {
    if (context.read<GroupChatBloc>().state.users.isNotEmpty) {
      // Start auto messaging chats with available users
      _setAutoMessages();
    } else {
      // Add test users to GroupChatBloc. Used for testing purposes
      context.read<GroupChatBloc>().add(const SetUsers([
            User(id: '1', name: 'Laura'),
            User(id: '2', name: 'Ricky'),
            User(id: '5', name: 'Summer'),
            User(id: '3', name: 'Emmanuel'),
            User(id: '4', name: 'Martins')
          ]));
    }

    super.initState();
  }

  void _setAutoMessages() {
    timer?.cancel();
    final state = context.read<GroupChatBloc>().state;
    // Add new message every few seconds, from randomly chosen user and textphrase
    timer = Timer(
      Duration(milliseconds: 300 + Random().nextInt(5000)),
      () {
        context.read<GroupChatBloc>().add(AddMessage(
              Message(
                data: generate(delimiter: ' '),
                id: state.messages.length.toString(),
                senderId: state.users[Random().nextInt(state.users.length)].id,
                timeSent: DateTime.now().toUtc(),
              ),
            ));
        _setAutoMessages();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupChatBloc, GroupChatState>(
      listenWhen: (prev, curr) => prev.users != curr.users,
      listener: (context, state) => _setAutoMessages(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1E252B),
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: const [
                _TitleBar(),
                Expanded(child: _Messages()),
                SafeArea(top: false, child: _InputBar()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatBox extends StatelessWidget {
  const _ChatBox(
    this.message, {
    Key? key,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: context.read<ProfileBloc>().state.user.id == message.senderId
          ? SenderChatText(message)
          : ReceiverChatText(message),
    );
  }
}

class _Messages extends StatefulWidget {
  const _Messages({Key? key}) : super(key: key);

  @override
  State<_Messages> createState() => _MessagesState();
}

class _MessagesState extends State<_Messages> {
  final controller = ScrollController();
  bool showScrollButton = false;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        showScrollButton = controller.offset > 90;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusWidget(
      child: BlocBuilder<GroupChatBloc, GroupChatState>(
        builder: (context, state) {
          if (state.messages.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'No messages here yet.',
                      style: TextStyle(
                        color: Colors.white,
                        height: 1.5,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text('👋', style: TextStyle(fontSize: 48)),
                  ],
                ),
              ),
            );
          }
          return Stack(
            children: [
              ListView.builder(
                reverse: true,
                itemCount: state.messages.length,
                physics: const BouncingScrollPhysics(),
                controller: controller,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                ),
                itemBuilder: (_, index) => _ChatBox(state.messages[index]),
              ),
              Positioned(
                bottom: 8,
                right: 10,
                child: AnimatedOpacity(
                  opacity: showScrollButton ? 1 : 0,
                  duration: kRadialReactionDuration,
                  child: IgnorePointer(
                    ignoring: !showScrollButton,
                    child: GestureDetector(
                      onTap: () {
                        controller.animateTo(0,
                            duration: kTabScrollDuration, curve: Curves.easeIn);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.arrow_downward_outlined),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
