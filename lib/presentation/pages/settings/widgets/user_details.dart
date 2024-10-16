import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:tody_app/bloc/user/user_notifier.dart';
import 'package:tody_app/core/constants/app_keys.dart';
import 'package:tody_app/core/constants/routes.dart';
import 'package:tody_app/core/theme/theme_ext.dart';
import 'package:tody_app/main.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserNotifier>().user;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (user != null) ...[
            CircleAvatar(
              radius: 30,
              backgroundColor: context.colors.primary,
              child: Text(
                user.avatarLabel ?? 'N/A',
                style: context.typography.titleLarge
                    .copyWith(color: context.colors.surface),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              user.fullName,
              style: context.typography.titleLarge,
            ),
            Text(
              user.username,
              style: context.typography.bodySmall
                  .copyWith(color: context.colors.onSurfaceMediumBrush),
            ),
            const SizedBox(height: 12),
          ],
          TextButton(
            onPressed: () {
              const storage = FlutterSecureStorage();
              storage.delete(key: AppKeys.token);
            },
            child: Text(
              'Sign out',
              style: context.typography.labelLarge
                  .copyWith(color: context.colors.error),
            ),
          ),
          const SizedBox(height: 13),
          Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          )
        ],
      ),
    );
  }
}
