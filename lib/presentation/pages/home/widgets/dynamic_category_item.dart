import 'package:flutter/material.dart';
import 'package:tody_app/core/app_colors.dart';
import 'package:tody_app/core/utils/extension/theme.ext.dart';
import 'package:tody_app/presentation/pages/home/widgets/category_item.dart';

class DynamicCategoryItem extends CategoryItem {
  const DynamicCategoryItem({
    super.key,
    required super.title,
    super.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return super.buildTile(
      context,
      Icon(
        Icons.list_outlined,
        color: Theme.of(context).select(
          light: AppColors.primaryInverse,
          dark: DarkAppColors.primaryInverse,
        ),
      ),
    );
  }
}
