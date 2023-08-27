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
          
          const SizedBox(width: 10),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: ChatAvatar(
              imageUrl:
                  'https://media.licdn.com/dms/image/C4E0BAQE1rik2cu-AOw/company-logo_200_200/0/1675248221466?e=1701302400&v=beta&t=qnKNwy25RBBerSX6kiMNIdDkJbLILU0IWvKm1rFIckU',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Kurero group',
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
          const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
