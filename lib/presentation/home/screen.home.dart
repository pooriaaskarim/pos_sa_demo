import 'dart:async';

import 'package:flutter/material.dart';

import 'tabs/google_map/tab.google_map.dart';
import 'tabs/notifications/tab.notifications.dart';
import 'widgets/button.theme_toggle.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static late final TabController tabController;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Home.tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    Home.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    const willPopDuration = Duration(seconds: 3);
    int willPopRetries = 0;

    Future<bool> onWillPop() async {
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
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
          bottomNavigationBar: _buildTabBar(),
        ),
      ),
    );
  }

  Widget _buildTabBar() => TabBar(
        padding: EdgeInsets.zero,
        isScrollable: false,
        indicatorSize: TabBarIndicatorSize.tab,
        controller: Home.tabController,
        tabs: const [
          Tab(
            text: 'Notifications',
          ),
          Tab(
            text: 'Map',
          ),
        ],
      );

  Widget _buildBody() => TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: Home.tabController,
        children: const [
          NotificationsTab(),
          GoogleMapsTab(),
        ],
      );

  AppBar _buildAppBar() => AppBar(
        title: const Text('Demo'),
        actions: const [ThemeToggleButton()],
      );
}
