// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:tody_app/test/state_scope.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const StateScopeWidget(
      child: Scaffold(
        body: ViewOfMyPage(),
      ),
    );
  }
}

class ViewOfMyPage extends StatelessWidget {
  const ViewOfMyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stateScope = StateScope.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: stateScope.color,
          width: 100,
          height: 100,
        ),
        Text(stateScope.value.toString(),
            style: Theme.of(context).textTheme.displayLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Change color',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Change color',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        )
      ],
    );
  }
}
