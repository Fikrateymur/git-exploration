import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tody_app/bloc/login/login_state.dart';
import 'package:tody_app/core/constants/app_keys.dart';

class LoginNotifier extends ChangeNotifier {
  LoginState _loginState = InitialState();
  LoginState get loginState => _loginState;

  void login({
    required String username,
    required String password,
  }) async {
    try {
      _loginState = LoadingState();
      notifyListeners();
      await Future.delayed(const Duration(seconds: 2));

      final uri = Uri.http('192.168.100.17:8080', '/auth/login');
      final response = await http.post(
        uri,
        body: jsonEncode(
          {
            "username": username,
            "password": password,
          },
        ),
      );

      if (response.statusCode == 200) {
        await _persistToken(username, password);
        _loginState = SuccessState();
        notifyListeners();
      } else {
        final error = response.body;
        _loginState = ErrorState(error);
        notifyListeners();
      }
    } catch (e) {
      _loginState = ErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> _persistToken(String username, String password) async {
    final basicAuthConfig = '$username:$password';
    final token = base64Encode(basicAuthConfig.codeUnits);
    const secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: AppKeys.token, value: token);
  }
}
