import '../models/user.dart';

/// Abstraksi sumber data auth. Di aplikasi nyata ini bisa
/// memanggil REST API / Firebase. Untuk materi testing kita
/// pakai Fake (tanpa package mockito) agar mudah dipahami.
abstract class AuthService {
  Future<User> login(String email, String password);
}

/// Fake manual untuk testing & demo.
class FakeAuthService implements AuthService {
  final Map<String, String> users; // email -> password
  final Duration delay;

  FakeAuthService({
    this.users = const {'budi@gmail.com': 'rahasia123'},
    this.delay = const Duration(milliseconds: 300),
  });

  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(delay);
    final savedPassword = users[email.trim()];
    if (savedPassword == null) {
      throw AuthException('User tidak ditemukan');
    }
    if (savedPassword != password) {
      throw AuthException('Password salah');
    }
    return User(id: '1', name: 'Budi', email: email.trim());
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}
