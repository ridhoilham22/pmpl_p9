import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pmpl_p9/pages/login_page.dart';
import 'package:pmpl_p9/repositories/auth_repository.dart';
import 'package:pmpl_p9/services/auth_service.dart';

Widget _sut() {
  final repo = AuthRepository(
    FakeAuthService(
      users: const {'budi@gmail.com': 'rahasia123'},
      delay: Duration.zero,
    ),
  );

  return MaterialApp(home: LoginPage(repository: repo));
}

void main() {
  group('LoginPage Widget Test', () {
    // 1. Menampilkan form email, password, dan tombol login
    testWidgets('menampilkan form email, password, dan tombol login', (
      tester,
    ) async {
      await tester.pumpWidget(_sut());

      expect(find.byKey(const Key('emailField')), findsOneWidget);

      expect(find.byKey(const Key('passwordField')), findsOneWidget);

      expect(find.byKey(const Key('loginButton')), findsOneWidget);
    });

    // 2. Tap login saat kosong -> muncul pesan validasi
    testWidgets('tap login saat kosong -> muncul pesan validasi', (
      tester,
    ) async {
      await tester.pumpWidget(_sut());

      await tester.tap(find.byKey(const Key('loginButton')));

      await tester.pump();

      expect(find.text('Email tidak boleh kosong'), findsOneWidget);

      expect(find.text('Password tidak boleh kosong'), findsOneWidget);
    });

    // 3. Login sukses -> tampil sapaan
    testWidgets('login sukses -> tampil sapaan', (tester) async {
      await tester.pumpWidget(_sut());

      await tester.enterText(
        find.byKey(const Key('emailField')),
        'budi@gmail.com',
      );

      await tester.enterText(
        find.byKey(const Key('passwordField')),
        'rahasia123',
      );

      await tester.tap(find.byKey(const Key('loginButton')));

      await tester.pumpAndSettle();

      expect(find.text('Selamat datang, Budi!'), findsOneWidget);
    });

    // 4. Password salah -> tampil pesan error
    testWidgets('password salah -> tampil pesan error', (tester) async {
      await tester.pumpWidget(_sut());

      await tester.enterText(
        find.byKey(const Key('emailField')),
        'budi@gmail.com',
      );

      await tester.enterText(
        find.byKey(const Key('passwordField')),
        'passwordsalah',
      );

      await tester.tap(find.byKey(const Key('loginButton')));

      await tester.pumpAndSettle();

      expect(find.text('Password salah'), findsOneWidget);
    });
  });
}
