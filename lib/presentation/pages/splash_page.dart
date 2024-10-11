import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tody_app/core/app_colors.dart';
// import 'package:tody_app/core/app_typhography.dart';
import 'package:tody_app/core/constants/app_icons.dart';
import 'package:tody_app/core/constants/app_keys.dart';
import 'package:tody_app/core/constants/routes.dart';
// import 'package:tody_app/presentation/pages/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    const secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: AppKeys.token);

    if (token != null && mounted) {
      Navigator.pushReplacementNamed(
        context,
        EnumRoutes.home.path,
      );
    } else {
      _chechIfAppOpenedPreviosly();
    }
  }

  void _chechIfAppOpenedPreviosly() async {
    final prefrences = await SharedPreferences.getInstance();
    final isAppOpened = prefrences.getBool(AppKeys.isAppOpened);
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      if (isAppOpened == null || !isAppOpened) {
        Navigator.pushReplacementNamed(
          context,
          EnumRoutes.onboarding.path,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          EnumRoutes.login.path,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkAppColors.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppIcons.splashLogo,
              fit: BoxFit.cover,
            ),

            // const SizedBox(height: 12),
            // Text(
            //   'Tody App',
            //   style: AppTyphography.sp26.w700.copyWith(
            //     color: AppColors.neutralWhite,
            //   ),
            // ),
            // const SizedBox(height: 12),
            // Text(
            //   'The best to do list application for you',
            //   style: AppTyphography.sp14.w400.copyWith(
            //     color: AppColors.neutralWhite,
            //     height: 20 / 14,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
