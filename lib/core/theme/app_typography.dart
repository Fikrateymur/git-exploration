import 'package:flutter/material.dart';

interface class AppTypography {
  AppTypography({
    required this.bodyLarge,
    required this.displaySmall,
    required this.labelLarge,
    required this.titleMedium,
    required this.titleLarge,
    required this.bodySmall,
  });

  factory AppTypography.regular() => _AppRegularTypography();

  ///label
  final TextStyle labelLarge;

  ///display
  final TextStyle displaySmall;

  ///title
  final TextStyle titleMedium;

  //titleLarge
  final TextStyle titleLarge;

  ///body
  final TextStyle bodyLarge;
  final TextStyle bodySmall;
}

class _AppRegularTypography implements AppTypography {
  @override
  TextStyle get bodyLarge => const TextStyle(
        fontSize: 16,
        height: 24 / 16,
      );

  @override
  TextStyle get displaySmall => const TextStyle(
        fontSize: 36,
        height: 44 / 36,
      );

  @override
  TextStyle get labelLarge => const TextStyle(
        fontSize: 14,
        height: 20 / 14,
      );

  @override
  TextStyle get titleMedium => const TextStyle(
        fontSize: 16,
        height: 24 / 16,
      );

  @override
  TextStyle get titleLarge => const TextStyle(
        fontSize: 22,
        height: 28 / 22,
      );

  @override
  TextStyle get bodySmall => const TextStyle(
        fontSize: 12,
        height: 16 / 12,
      );
}

extension TextStyleExt on TextStyle {
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
}
