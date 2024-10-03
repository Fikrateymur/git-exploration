import 'package:flutter/material.dart';
import 'package:tody_app/core/app_colors.dart';
import 'package:tody_app/core/app_typhography.dart';
import 'package:tody_app/core/constants/routes.dart';
import 'package:tody_app/presentation/pages/login_page.dart';
import 'package:tody_app/presentation/pages/onboarding_page.dart';
import 'package:tody_app/presentation/pages/splash_page.dart';
// import 'package:tody_app/presentation/pages/splash_page.dart';
// import 'package:tody_app/test/my_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          displaySmall: AppTyphography.displaySmall.w400.copyWith(
            color: AppColors.onSurface,
          ),
          titleMedium: AppTyphography.titleMedium.w500.copyWith(
            color: AppColors.pimaryVariant,
          ),
        ),
        scaffoldBackgroundColor: AppColors.surface,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            textStyle: AppTyphography.labelLarge.w500.copyWith(
              color: AppColors.onPrimary,
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          displaySmall: AppTyphography.displaySmall.w400.copyWith(
            color: DarkAppColors.onSurface,
          ),
          titleMedium: AppTyphography.titleMedium.w500.copyWith(
            color: DarkAppColors.pimaryVariant,
          ),
        ),
        scaffoldBackgroundColor: DarkAppColors.surface,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: DarkAppColors.primary,
            textStyle: AppTyphography.labelLarge.w500.copyWith(
              color: AppColors.onPrimary,
            ),
          ),
        ),
      ),
      initialRoute: EnumRoutes.splash.path,
      routes: {
        EnumRoutes.splash.path: (context) => const SplashPage(),
        EnumRoutes.onboarding.path: (context) => const OnboardingPage(),
        EnumRoutes.login.path: (context) => const LoginPage(),
      },
    );
  }
}
