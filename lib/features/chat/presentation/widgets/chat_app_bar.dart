part of '../screens/chat_screen.dart';

class _TitleBar extends StatelessWidget {
  const _TitleBar({Key? key}) : super(key: key);

  final duration = const Duration(minutes: 30);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Row(
        children: [
          if (Navigator.of(context).canPop())
            const Padding(
              padding: EdgeInsets.only(left: 9),
              child: BackButtonWhite(),
            ),
          const SizedBox(width: 8),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: GroupAvatar(size: 44),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Kureko group',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {}),
        ],
      ),
    );
  }
}
