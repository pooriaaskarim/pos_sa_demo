library home;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/app_bloc/app_bloc.dart';
import '../../infrastructure/utils/app.sizes.dart';
import '../../infrastructure/utils/app.utils.dart';
import 'widgets/body/tabs/map/tab.map.dart';
import 'widgets/body/tabs/notifications/tab.notifications.dart';

part 'widgets/body/body.dart';
part 'widgets/button.theme_toggle.dart';
part 'widgets/header/header.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(final BuildContext context) {
    const willPopDuration = Duration(seconds: 3);
    int willPopRetries = 0;

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Press BACK again to exit',
            ),
            duration: willPopDuration,
          ),
        );
        willPopRetries++;
        unawaited(
          Future.delayed(willPopDuration)
              .then((final value) => willPopRetries = 0),
        );
        return willPopRetries > 1;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Demo'),
            actions: const [ThemeToggleButton()],
          ),
          body: const Body(),
        ),
      ),
    );
  }
}
