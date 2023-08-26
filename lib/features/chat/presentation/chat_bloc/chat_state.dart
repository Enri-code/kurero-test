part of 'chat_bloc.dart';

class GroupChatState extends Equatable {
  const GroupChatState({
    this.messages = const [],
    this.users = const [],
  });

  factory GroupChatState.fromJson(Map<String, dynamic> json) {
    return GroupChatState(
      messages: (json['messages'] as List)
          .cast<Map<String, dynamic>>()
          .map(Message.fromJson)
          .toList(),
      users: (json['users'] as List)
          .cast<Map<String, dynamic>>()
          .map(User.fromJson)
          .toList(),
    );
  }

  final List<Message> messages;
  final List<User> users;

  Map<String, dynamic> toJson() => {
        'messages': messages.map((e) => e.toJson()).toList(),
        'users': users.map((e) => e.toJson()).toList(),
      };

  GroupChatState copyWith({
    int? highlightIndex,
    List<Message>? messages,
    List<User>? users,
  }) {
    return GroupChatState(
      messages: messages ?? this.messages,
      users: users ?? this.users,
    );
  }

  @override
  List<Object?> get props => [messages, users];
}
