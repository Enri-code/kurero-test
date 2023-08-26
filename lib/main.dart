import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kureko_test/core/theme/theme_data.dart';
import 'package:kureko_test/features/chat/presentation/chat_bloc/chat_bloc.dart';
import 'package:kureko_test/features/chat/presentation/screens/chat_screen.dart';
import 'package:kureko_test/features/profile/bloc/profile_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GroupChatBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
      ],
      child: MaterialApp(
        title: 'Kureko',
        debugShowCheckedModeBanner: false,
        theme: ThemeBuilder(primaryColor: Colors.blue).theme,
        home: const ChatScreen(),
      ),
    );
  }
}
