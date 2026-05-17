import 'dart:developer';

import 'package:flutter/material.dart';

import '../features/home/view/homesceen.dart';
import '../features/navigation/view/navigation_screen.dart';
import '../features/splash/view/splash_screen.dart';


class SimpleRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  String? currentRouteName;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    currentRouteName = route.settings.name;
    log('Route pushed: $currentRouteName');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    currentRouteName = previousRoute?.settings.name;
    log('Route popped: ${route.settings.name}');
  }
}


final simpleRouteObserver = SimpleRouteObserver();

class AppRoute {
  static List<Route<dynamic>> onGenerateInitialRoute(String path) {
    Uri uri = Uri.parse(path);
    log(uri.toString());
    return [
      pageRoute(
        const RouteSettings(name: SplashScreen.path),
        const SplashScreen(),
      ),
    ];
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    log(settings.name.toString());
    Uri uri = Uri.parse(settings.name ?? "");
    final Widget screen;

    switch (uri.path) {
      case SplashScreen.path:
        screen = const SplashScreen();
        break;

      case NavigationScreen.path:
        screen = const NavigationScreen();
        break;

      case HomeScreen.path:
        screen = const HomeScreen();
        break;

      default:
        return null;
    }
    return pageRoute(settings, screen);
  }
}

Route<T> pageRoute<T>(
  RouteSettings settings,
  Widget screen, {
  bool animate = true,
}) {
  if (!animate) {
    return PageRouteBuilder(
      settings: settings,
      opaque: true,
      pageBuilder: (context, animation, secondaryAnimation) => screen,
    );
  }
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (_, _, _) => screen,
    transitionsBuilder: (_, animation, _, child) {
      final fade = CurvedAnimation(parent: animation, curve: Curves.easeOut);

      final slide = Tween<Offset>(
        begin: const Offset(0.03, 0),
        end: Offset.zero,
      ).animate(animation);

      return FadeTransition(
        opacity: fade,
        child: SlideTransition(position: slide, child: child),
      );
    },
  );
}


Future<T?> navigate<T extends Object?>(
  BuildContext context,
  String routeName, {
  Object? arguments,
  bool duplicate = false,
  bool replace = false,
  bool mainRoute = false,
}) async {
  final currentRoute = mainRoute
      ? simpleRouteObserver.currentRouteName
      : ModalRoute.of(context)?.settings.name;
  log('Current route: $currentRoute, Navigating to: $routeName');

  if (routeName == currentRoute && !duplicate) return null;

  if (replace) {
    return await Navigator.of(context).pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  } else {
    return await Navigator.of(
      context,
    ).pushNamed<T>(routeName, arguments: arguments);
  }
}