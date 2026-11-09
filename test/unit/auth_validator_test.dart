import 'package:flutter_test/flutter_test.dart';
import 'package:pmpl_p9/validators/auth_validator.dart';

void main() {
  group('AuthValidator.validateEmail', () {
    test('email valid -> null', () {
      expect(AuthValidator.validateEmail('budi@gmail.com'), isNull);
    });

    test('email kosong -> error', () {
      expect(AuthValidator.validateEmail(''), 'Email tidak boleh kosong');

      expect(AuthValidator.validateEmail(' '), 'Email tidak boleh kosong');

      expect(AuthValidator.validateEmail(null), 'Email tidak boleh kosong');
    });

    test('email tanpa @ atau titik -> error', () {
      expect(AuthValidator.validateEmail('budi'), 'Format email tidak valid');

      expect(
        AuthValidator.validateEmail('budi@mail'),
        'Format email tidak valid',
      );
    });
  });

  group('AuthValidator.validatePassword', () {
    test('password >= 6 karakter -> null', () {
      expect(AuthValidator.validatePassword('rahasia123'), isNull);
    });

    test('password kosong -> error', () {
      expect(AuthValidator.validatePassword(''), 'Password tidak boleh kosong');

      expect(
        AuthValidator.validatePassword(null),
        'Password tidak boleh kosong',
      );
    });

    test('password < 6 karakter -> error', () {
      expect(
        AuthValidator.validatePassword('12345'),
        'Password minimal 6 karakter',
      );
    });
  });
}
