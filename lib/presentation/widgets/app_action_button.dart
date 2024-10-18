import 'package:flutter/material.dart';
import 'package:tody_app/core/theme/theme_ext.dart';

class AppActionButton extends StatelessWidget {
  const AppActionButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback? onPressed;
  // final Color? color;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 150,
        // maxWidth: 150,
        minHeight: 40,
        maxHeight: 60,
      ),
      child: Material(
        color: context.colors.primary,
        borderRadius: BorderRadius.circular(20),
        elevation: 4.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            child: Center(
              child: Text(
                title,
                style: context.typography.labelLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
