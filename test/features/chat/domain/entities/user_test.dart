import 'package:flutter_test/flutter_test.dart';
import 'package:kurero_test/features/chat/domain/entities/user.dart';

void main() {
  test('test fromJson', () {
    final json = {'id': 'id', 'name': 'name'};
    expect(User.fromJson(json).id, 'id');
    expect(User.fromJson(json).name, 'name');
  });
  test('test toJson', () {
    final json = {'id': 'id', 'name': 'name'};
    expect(User(id: 'id', name: 'name').toJson(), json);
  });
}
