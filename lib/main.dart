import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'repositories/auth_repository.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pertemuan 9 - Testing',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: LoginPage(repository: AuthRepository(FakeAuthService())),
    );
  }
}
