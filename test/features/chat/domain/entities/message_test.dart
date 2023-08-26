import 'package:flutter_test/flutter_test.dart';
import 'package:kureko_test/features/chat/domain/entities/message.dart';

void main() {
  test('Message equatable succeeds on instances with same properties', () {
    expect(
      Message(data: 'data', senderId: 'senderId'),
      Message(data: 'data', senderId: 'senderId'),
    );
    expect(
      Message(data: 'data', senderId: 'senderId'),
      isNot(Message(data: 'data', senderId: 'receiverId')),
    );
  });

  test('test fromJson', () {
    final json = {
      'id': 'id',
      'senderId': 'senderId',
      'data': 'data',
      'isSent': false,
      'timeSent': 0,
    };
    expect(
      Message.fromJson(json),
      Message(
        data: 'data',
        senderId: 'senderId',
        isSent: false,
        id: 'id',
        timeSent: DateTime.fromMillisecondsSinceEpoch(0),
      ),
    );
  });
  test('test toJson', () {
    final json = {
      'id': 'id',
      'data': 'data',
      'senderId': 'senderId',
      'isSent': false,
      'timeSent': 10000,
    };
    expect(
      Message(
        data: 'data',
        senderId: 'senderId',
        isSent: false,
        id: 'id',
        timeSent: DateTime.fromMillisecondsSinceEpoch(10000),
      ).toJson(),
      json,
    );
  });
}
