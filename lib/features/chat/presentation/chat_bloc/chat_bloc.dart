import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kurero_test/features/chat/domain/entities/message.dart';
import 'package:kurero_test/features/chat/domain/entities/user.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class GroupChatBloc extends HydratedBloc<ChatEvent, GroupChatState> {
  GroupChatBloc() : super(const GroupChatState()) {
    on<AddMessage>(_addMessage);
    on<SetUsers>(_setUsers);
  }

  void _addMessage(AddMessage event, Emitter<GroupChatState> emit) async {
    emit(state.copyWith(messages: [event.message, ...state.messages]));
  }

  void _setUsers(SetUsers event, Emitter<GroupChatState> emit) async {
    emit(state.copyWith(users: event.users));
  }

  @override
  GroupChatState? fromJson(Map<String, dynamic> json) =>
      GroupChatState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(GroupChatState state) => state.toJson();
}

extension GroupChatBlocExt on GroupChatBloc {
  User getUserFromId(String id) {
    return state.users.firstWhere(
      (e) => e.id == id,
      //Return a user with name 'Unknown' if id is not recognised
      orElse: () => User(id: id, name: 'Unknown'),
    );
  }
}
