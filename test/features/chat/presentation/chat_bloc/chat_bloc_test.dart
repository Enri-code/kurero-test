import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kureko_test/features/chat/domain/entities/message.dart';
import 'package:kureko_test/features/chat/domain/entities/user.dart';
import 'package:kureko_test/features/chat/presentation/chat_bloc/chat_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {}

class MockGroupChatBloc extends Mock implements GroupChatBloc {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  late Storage storage;

  setUp(() {
    storage = MockStorage();
    when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  });

  test('test getUserFromId returns correct User', () {
    final bloc = MockGroupChatBloc();
    when(() => bloc.state).thenReturn(const GroupChatState(
      users: [
        User(id: '1', name: 'Laura'),
        User(id: '2', name: 'Eric'),
        User(id: '4', name: 'Martins')
      ],
    ));
    expect(bloc.getUserFromId('2'), const User(id: '2', name: 'Eric'));
  });

  blocTest<GroupChatBloc, GroupChatState>(
    'emits [1 message] when messages are empty.',
    build: () => GroupChatBloc(),
    act: (bloc) => bloc.add(const SetUsers([User(id: '1', name: 'Laura')])),
    expect: () => const <GroupChatState>[
      GroupChatState(users: [User(id: '1', name: 'Laura')]),
    ],
  );

  group('test AddMessage', () {
    blocTest<GroupChatBloc, GroupChatState>(
      'emits [1 message] when messages are empty.',
      build: () => GroupChatBloc(),
      act: (bloc) => bloc.add(const AddMessage(
        Message(data: 'Hi', senderId: '1'),
      )),
      expect: () => const <GroupChatState>[
        GroupChatState(messages: [Message(data: 'Hi', senderId: '1')]),
      ],
    );
    blocTest<GroupChatBloc, GroupChatState>(
      'emits [second message] at first index.',
      build: () => GroupChatBloc(),
      seed: () =>
          const GroupChatState(messages: [Message(data: 'Hi', senderId: '1')]),
      act: (bloc) =>
          bloc.add(const AddMessage(Message(data: 'Hello', senderId: '2'))),
      expect: () => const <GroupChatState>[
        GroupChatState(
          messages: [
            Message(data: 'Hello', senderId: '2'),
            Message(data: 'Hi', senderId: '1'),
          ],
        ),
      ],
    );
  });
}
