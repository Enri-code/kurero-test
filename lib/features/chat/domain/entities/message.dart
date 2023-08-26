import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String? id;
  final String senderId;
  final bool isSent;
  final String data;
  final DateTime? timeSent;

  const Message({
    required this.data,
    required this.senderId,
    this.id,
    this.isSent = true,
    this.timeSent,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      data: json['data'],
      senderId: json['senderId'],
      id: json['id'],
      isSent: json['isSent'],
      timeSent: DateTime.fromMillisecondsSinceEpoch(json['timeSent']),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data,
        'senderId': senderId,
        'timeSent': timeSent?.millisecondsSinceEpoch,
        'id': id,
        'isSent': isSent,
      };

  @override
  List<Object?> get props => [data, id, isSent, timeSent, senderId];
}
