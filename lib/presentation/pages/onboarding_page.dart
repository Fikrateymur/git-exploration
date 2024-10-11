import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tody_app/core/app_colors.dart';
// import 'package:tody_app/core/app_typhography.dart';
import 'package:tody_app/core/constants/app_icons.dart';
import 'package:tody_app/core/constants/app_keys.dart';
import 'package:tody_app/core/constants/routes.dart';
// import 'package:tody_app/presentation/widgets/app_action_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                AppIcons.splashLogo2,
                scale: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Text(
                    'Welcome to\n Uno To Do!',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Start using the best To Do App',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 80),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final preferences =
                            await SharedPreferences.getInstance();
                        await preferences.setBool(AppKeys.isAppOpened, true);
                        if (mounted) {
                          Navigator.pushReplacementNamed(
                            context,
                            EnumRoutes.login.path,
                          );
                        }
                      },
                      child: Text(
                        'Get started',
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.textStyle
                            ?.resolve(
                              WidgetState.values.toSet(),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
