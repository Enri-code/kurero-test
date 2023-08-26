part of '../screens/chat_screen.dart';

class _InputBar extends StatefulWidget {
  const _InputBar({Key? key}) : super(key: key);

  @override
  State<_InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<_InputBar> {
  final textController = TextEditingController();
  bool canSend = false;

  @override
  void initState() {
    textController.addListener(() {
      setState(() => canSend = textController.text.trim().isNotEmpty);
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 52),
      child: Container(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                minLines: 1,
                maxLines: 5,
                controller: textController,
                textInputAction: TextInputAction.newline,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  filled: false,
                  hintText: 'Type something...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintStyle: TextStyle(fontWeight: FontWeight.w600),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 4,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: IconButton(
                color: Theme.of(context).primaryColor,
                icon: const Icon(Icons.send, size: 24),
                onPressed: canSend
                    ? () {
                        final state = context.read<GroupChatBloc>().state;
                        context.read<GroupChatBloc>().add(AddMessage(
                              Message(
                                data: textController.text.trim(),
                                id: state.messages.length.toString(),
                                senderId:
                                    context.read<ProfileBloc>().state.user.id,
                                timeSent: DateTime.now().toUtc(),
                              ),
                            ));
                        textController.clear();
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
