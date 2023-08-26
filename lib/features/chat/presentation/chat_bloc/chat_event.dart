part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}


class AddMessage extends ChatEvent {
  const AddMessage(this.message);
  final Message message;
}

class SetUsers extends ChatEvent {
  const SetUsers(this.users);
  final List<User> users;
}
