import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tody_app/core/constants/app_keys.dart';
import 'package:tody_app/model/user.dart';
import 'package:http/http.dart' as http;

class UserNotifier extends ChangeNotifier {
  User? user;

  Future<void> fetchUser() async {
    final uri = Uri.http('192.168.0.107:8080', '/auth/user');

    const secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: AppKeys.token);

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Basic $token',
      },
    );

    final decodedUser = jsonDecode(response.body);
    final userResponse = User.fromJson(decodedUser);

    final nameWords = userResponse.fullName.split(' ');
    final buffer = StringBuffer();

    for (var word in nameWords) {
      buffer.write(word[0]);
    }

    final updatedUser = userResponse.copyWith(
      avatarLabel: buffer.toString(),
    );

    user = updatedUser;
    notifyListeners();
  }
}
