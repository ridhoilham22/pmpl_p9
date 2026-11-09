import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pmpl_p9/models/user.dart';
import 'package:pmpl_p9/services/auth_service.dart';
import 'package:pmpl_p9/repositories/auth_repository.dart';

// Membuat Mock AuthService
class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockAuthService;
  late AuthRepository authRepository;

  setUp(() {
    mockAuthService = MockAuthService();
    authRepository = AuthRepository(mockAuthService);
  });

  group('AuthRepository', () {
    // 1. Test login berhasil
    test('login returns User when credentials are valid', () async {
      const email = 'budi@gmail.com';
      const password = 'rahasia123';

      const user = User(id: '1', name: 'Budi', email: email);

      when(() => mockAuthService.login(email, password))
          .thenAnswer((_) async => user);

      final result = await authRepository.login(email, password);

      expect(result, user);
      expect(result.email, email);

      verify(() => mockAuthService.login(email, password)).called(1);
    });

    // 2. Test login gagal
    test('login throws exception when credentials are invalid', () async {
      const email = 'salah@gmail.com';
      const password = 'password123';

      when(() => mockAuthService.login(email, password))
          .thenThrow(Exception('Login gagal'));

      expect(
        () => authRepository.login(email, password),
        throwsA(isA<Exception>()),
      );

      verify(() => mockAuthService.login(email, password)).called(1);
    });

    // 3. Test memastikan email dan password diteruskan
    test('login passes correct credentials to AuthService', () async {
      const email = 'ani@gmail.com';
      const password = 'rahasia456';

      const user = User(id: '2', name: 'Ani', email: email);

      when(() => mockAuthService.login(email, password))
          .thenAnswer((_) async => user);

      await authRepository.login(email, password);

      verify(() => mockAuthService.login(email, password)).called(1);
    });
  });
}
