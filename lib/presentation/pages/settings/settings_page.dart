import 'package:flutter/material.dart';
import 'package:tody_app/core/constants/routes.dart';
import 'package:tody_app/core/theme/app_theme_scope.dart';
import 'package:tody_app/core/theme/theme_ext.dart';
import 'package:tody_app/core/utils/extension/context_ext.dart';
import 'package:tody_app/presentation/pages/settings/widgets/settings_bar.dart';
import 'package:tody_app/presentation/pages/settings/widgets/user_details.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Navigator.of(context).pop,
          child: const Icon(Icons.close),
        ),
        title: Text(
          context.l10n.settings,
          style: context.typography.titleLarge,
        ),
        backgroundColor: context.colors.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            const UserDetails(),
            Text(
              'General',
              style: context.typography.labelLarge
                  .copyWith(color: context.colors.primary),
            ),
            const SizedBox(height: 10),
            SettingsBar<Locale>(
              title: 'Language',
              defaultSelectedType: const Locale('en'),
              onChipSelected: (locale) {},
              chips: [
                SettingsItem(
                  title: 'English',
                  type: Locale('en'),
                ),
                SettingsItem(
                  title: 'Azerbaijani',
                  type: Locale('az'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SettingsBar<ThemeMode>(
              title: 'Mode',
              defaultSelectedType: ThemeMode.light,
              onChipSelected: (themeMode) {},
              chips: [
                SettingsItem(
                  title: 'Light',
                  prefix: Icon(Icons.light_mode),
                  type: ThemeMode.light,
                ),
                SettingsItem(
                  title: 'Dark',
                  prefix: Icon(Icons.dark_mode),
                  type: ThemeMode.dark,
                ),
                SettingsItem(
                  title: 'System',
                  type: ThemeMode.system,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
