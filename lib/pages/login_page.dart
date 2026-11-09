import 'package:flutter/material.dart';

import '../repositories/auth_repository.dart';
import '../services/auth_service.dart';
import '../validators/auth_validator.dart';

/// Halaman login sederhana.
class LoginPage extends StatefulWidget {
  final AuthRepository repository;

  const LoginPage({super.key, required this.repository});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _message;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _message = null;
    });
    try {
      final user = await widget.repository.login(
        _emailController.text,
        _passwordController.text,
      );
      setState(() => _message = 'Selamat datang, ${user.name}!');
    } on AuthException catch (e) {
      setState(() => _message = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: const Key('emailField'),
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: AuthValidator.validateEmail,
              ),
              TextFormField(
                key: const Key('passwordField'),
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: AuthValidator.validatePassword,
              ),
              const SizedBox(height: 16),
              if (_loading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  key: const Key('loginButton'),
                  onPressed: _submit,
                  child: const Text('Login'),
                ),
              if (_message != null) ...[
                const SizedBox(height: 16),
                Text(_message!, key: const Key('messageText')),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
