import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:tody_app/core/constants/app_keys.dart';
import 'package:tody_app/core/constants/routes.dart';
import 'package:tody_app/counter_notifier.dart';
import 'package:tody_app/presentation/settings/settings_scope.dart';
import 'package:tody_app/presentation/settings/settings_scope_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = SettingsScope.of(context)!.themeMode;
    // final value = context.read<String>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Switch.adaptive(
            value: themeMode == ThemeMode.dark,
            onChanged: (value) {
              SettingsScopeWidget.of(context)!.toggleTheme();
            },
          ),
          IconButton(
            onPressed: () async {
              await const FlutterSecureStorage().write(
                key: AppKeys.token,
                value: null,
              );

              if (!context.mounted) return;

              Navigator.of(context).pushNamedAndRemoveUntil(
                  EnumRoutes.login.path, (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Consumer<CounterNotifier>(
              builder: (BuildContext context, notifier, _) {
                return Text(
                  notifier.counter.toString(),
                  style: const TextStyle(fontSize: 40),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: context.read<CounterNotifier>().increment,
                child: const Text('Increment'),
              ),
              ElevatedButton(
                onPressed: context.read<CounterNotifier>().decrement,
                child: const Text('Decrement'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
