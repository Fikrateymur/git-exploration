import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tody_app/core/app_colors.dart';
import 'package:tody_app/core/constants/app_keys.dart';
import 'package:tody_app/core/constants/routes.dart';
import 'package:tody_app/presentation/widgets/app_action_button.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _login() async {
    try {
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      final uri = Uri.http('192.168.100.60:8080', '/auth/login');

      final response = await http.post(
        uri,
        body: jsonEncode(
          {
            "username": username,
            "password": password,
          },
        ),
      );
      if (!mounted) return;

      if (response.statusCode == 200) {
        await _persistToken(username, password);

        if (!context.mounted) return;
        Navigator.of(context).pushReplacementNamed(EnumRoutes.home.path);
      } else {
        final error = response.body;

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(error),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
      }
    } catch (e) {
      debugPrintThrottled(e.toString());
    }
  }

  Future<void> _persistToken(String username, String password) async {
    final basicAuthConfig = '$username:$password';
    final token = base64Encode(basicAuthConfig.codeUnits);
    final secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: AppKeys.token, value: token);
  }

  @override
  Widget build(BuildContext context) {
    final border = const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.onPrimary,
      ),
    );

    final errorBorder = border.copyWith(
      borderSide: const BorderSide(color: Colors.redAccent),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Login'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  enabledBorder: border,
                  focusedBorder: border,
                  errorBorder: errorBorder,
                  focusedErrorBorder: errorBorder,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabledBorder: border,
                  focusedBorder: border,
                  errorBorder: errorBorder,
                  focusedErrorBorder: errorBorder,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Password is required and must be at least 6 characters';
                  }
                  return null;
                },
                obscureText: !_isPasswordVisible,
                obscuringCharacter: '*',
              ),
              const SizedBox(height: 56),
              AppActionButton(
                title: 'Login',
                onPressed: () {
                  // _login();
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    _login();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
