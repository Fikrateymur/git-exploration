import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tody_app/bloc/login/login_notifier.dart';
import 'package:tody_app/bloc/user/user_notifier.dart';
import 'package:tody_app/core/constants/routes.dart';
import 'package:tody_app/presentation/pages/home/home_page.dart';
import 'package:tody_app/presentation/pages/login_page.dart';
import 'package:tody_app/presentation/pages/onboarding_page.dart';
import 'package:tody_app/presentation/pages/settings/settings_page.dart';
import 'package:tody_app/presentation/pages/splash_page.dart';
import 'package:tody_app/presentation/settings/settings_scope.dart';
import 'package:tody_app/presentation/settings/settings_scope_widget.dart';
import 'package:tody_app/core/theme/app_colors.dart';
import 'package:tody_app/core/theme/app_theme.dart';
import 'package:tody_app/core/theme/app_theme_scope.dart';
import 'package:tody_app/core/theme/app_typography.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    SettingsScopeWidget(
      preferences: preferences,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeMode = SettingsScope.of(context)!.themeMode;
    final colors = themeMode.index == ThemeMode.light
        ? AppColors.dark()
        : AppColors.light();

    final typography = AppTypography(
      displaySmall: TextStyle(
        fontSize: 36,
        height: 44 / 36,
        color: colors.onSurface,
        fontWeight: FontWeight.w400,
      ),
      labelLarge:
          TextStyle(fontSize: 14, height: 20 / 14, color: colors.primary),
      titleMedium: TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        color: colors.primaryVariant,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w500,
        color: colors.onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        height: 28 / 22,
        fontWeight: FontWeight.w400,
        color: colors.onSurface,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
        color: colors.onSurface,
      ),
    );

    return AppThemeScope(
      theme: AppTheme(
        colors: colors,
        typography: typography,
      ),
      child: MaterialApp(
        title: 'Tody App',
        locale: const Locale('az'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        themeMode: SettingsScope.of(context)?.themeMode,
        initialRoute: EnumRoutes.splash.path,
        builder: (context, child) {
          return MediaQuery.withClampedTextScaling(
            child: child!,
            minScaleFactor: 1.0,
            maxScaleFactor: 1.3,
          );
        },
        routes: {
          EnumRoutes.splash.path: (context) => const SplashPage(),
          EnumRoutes.onboarding.path: (context) => const OnboardingPage(),
          EnumRoutes.login.path: (context) => ChangeNotifierProvider(
                create: (context) => LoginNotifier(),
                child: const LoginPage(),
              ),
          EnumRoutes.home.path: (context) => ChangeNotifierProvider(
                lazy: true,
                create: (context) => UserNotifier()..fetchUser(),
                child: const HomePage(),
              ),
          EnumRoutes.settings.path: (context) {
            final modalRoute = ModalRoute.of(context)!;
            final settings = modalRoute.settings;

            return ChangeNotifierProvider.value(
              value: settings.arguments as UserNotifier,
              child: const SettingsPage(),
            );
          },
        },
      ),
    );
  }
}
