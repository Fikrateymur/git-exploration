import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:tody_app/bloc/user/user_notifier.dart';
import 'package:tody_app/core/constants/app_keys.dart';
import 'package:tody_app/core/constants/routes.dart';
import 'package:tody_app/main.dart';
// import 'package:tody_app/presentation/pages/home/widgets/category_item.dart';
import 'package:tody_app/presentation/pages/home/widgets/dynamic_category_item.dart';
import 'package:tody_app/presentation/pages/home/widgets/static_category_item.dart';
import 'package:tody_app/core/theme/theme_ext.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserNotifier>().user;

    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                if (user != null)
                  ListTile(
                    contentPadding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      right: 10,
                      left: 20,
                    ),
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          EnumRoutes.settings.path,
                          arguments: context.read<UserNotifier>(),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: context.colors.onPrimary,
                        child: Text(
                          user.avatarLabel ?? 'N/A',
                          style: context.typography.labelLarge,
                        ),
                      ),
                    ),
                    title: Text(
                      user.fullName,
                      style: context.typography.titleMedium,
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                      color: context.colors.primary,
                    ),
                  ),
                StaticCategoryItem(
                  prefix: Icon(Icons.star_rate, color: context.colors.error),
                  title: AppLocalizations.of(context).important,
                  onTap: () {},
                ),
                StaticCategoryItem(
                  prefix:
                      Icon(Icons.house_siding, color: context.colors.primary),
                  title: AppLocalizations.of(context).tasks,
                  onTap: () {},
                ),
              ],
            ),
            const Divider(),
            Flexible(
              child: ListView(
                children: const [
                  DynamicCategoryItem(title: 'Task List'),
                  DynamicCategoryItem(title: 'Flutter List'),
                ],
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).light),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 32,
                  top: 10,
                  bottom: 10,
                  right: 36,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: context.colors.primary,
                    ),
                    Text(
                      'New list',
                      style: context.typography.labelLarge,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
