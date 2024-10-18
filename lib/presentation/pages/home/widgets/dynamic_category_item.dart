import 'package:flutter/material.dart';
import 'package:tody_app/presentation/pages/home/widgets/category_item.dart';
import 'package:tody_app/core/theme/theme_ext.dart';

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
        color: context.colors.primaryInverse,
      ),
    );
  }
}
