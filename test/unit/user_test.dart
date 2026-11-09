import 'package:flutter_test/flutter_test.dart';
import 'package:pmpl_p9/models/user.dart';

void main() {
  group('User Model', () {
    // 1. Test fromJson
    test('fromJson returns valid User', () {
      final json = {'id': '1', 'name': 'Budi', 'email': 'budi@gmail.com'};

      final user = User.fromJson(json);

      expect(user.id, '1');
      expect(user.name, 'Budi');
      expect(user.email, 'budi@gmail.com');
    });

    // 2. Test toJson
    test('toJson returns correct map', () {
      const user = User(id: '1', name: 'Budi', email: 'budi@gmail.com');

      expect(user.toJson(), {
        'id': '1',
        'name': 'Budi',
        'email': 'budi@gmail.com',
      });
    });

    // 3. Test Round-trip
    test('fromJson -> toJson bersifat simetris (round-trip)', () {
      final json = {'id': '2', 'name': 'Ani', 'email': 'ani@gmail.com'};

      final user = User.fromJson(json);

      // Memastikan integritas data bolak-balik
      expect(user.toJson(), json);
    });

    // 4. Test Equality & hashCode
    test('equality: dua User dengan field sama dianggap sama', () {
      const a = User(id: '1', name: 'Budi', email: 'budi@gmail.com');

      const b = User(id: '1', name: 'Budi', email: 'budi@gmail.com');

      // Value equality vs Reference equality
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    // 5. Test copyWith
    test('copyWith mengubah field yang dipilih saja', () {
      const user = User(id: '1', name: 'Budi', email: 'budi@gmail.com');

      // Mengubah hanya nama, id & email tetap
      final renamed = user.copyWith(name: 'Budi Santoso');

      expect(renamed.name, 'Budi Santoso');
      expect(renamed.id, '1');
      expect(renamed.email, 'budi@gmail.com');
    });
  });
}
