import 'package:flutter/material.dart';

import '../../../presentation/home/screen.home.dart';
import '../../../presentation/splash/screen.splash.dart';
import 'app.route_names.dart';

class AppRoutes {
  AppRoutes._();

  static MaterialPageRoute getRoute(final String routeName) =>
      routes.containsKey(routeName)
          ? routes[routeName]!()
          : routes[AppRouteNames.notFound]!();

  static Map<String, MaterialPageRoute Function()> routes = {
    AppRouteNames.home: () => MaterialPageRoute(
          builder: (final context) => const Home(),
        ),
    AppRouteNames.splashScreen: () => MaterialPageRoute(
          builder: (final context) => const SplashScreen(),
        ),
  };
}
