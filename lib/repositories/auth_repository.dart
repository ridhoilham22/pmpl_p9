import '../models/user.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService service;

  AuthRepository(this.service);

  Future<User> login(String email, String password) {
    return service.login(email, password);
  }
}
