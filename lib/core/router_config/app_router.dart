import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onboarding_app/base_page.dart';
import 'package:onboarding_app/core/router_config/route_name.dart';
import 'package:onboarding_app/features/explore/presentation/pages/explore_page.dart';
import 'package:onboarding_app/features/home/presentation/pages/home_page.dart';
import 'package:onboarding_app/features/onboarding/presentation/pages/splash_page.dart';
import 'package:onboarding_app/features/onboarding/presentation/pages/welcome_page.dart';
import 'package:onboarding_app/features/profile/presentation/pages/profile_page.dart';
import 'package:onboarding_app/features/profile/presentation/pages/profile_setup_page.dart';
import 'package:onboarding_app/features/profile/presentation/pages/theme_setting_page.dart';

GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

Page<dynamic> _customTransitionPage({required Widget child}) {
  return CustomTransitionPage(
    key: ValueKey(child.toString()),
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 100),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0), // Slide from right
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    },
  );
}

final router = GoRouter(
  initialLocation: RouteName.splashPage,
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: RouteName.splashPage,
      name: RouteName.splashPage,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RouteName.welcomePage,
      name: RouteName.welcomePage,
      pageBuilder:
          (context, state) => _customTransitionPage(child: WelcomePage()),
    ),
    GoRoute(
      path: RouteName.profileSetupPage,
      name: RouteName.profileSetupPage,
      pageBuilder:
          (context, state) => _customTransitionPage(child: ProfileSetupPage()),
    ),

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return BasePage(child: child);
      },
      routes: [
        GoRoute(
          path: RouteName.homePage,
          name: RouteName.homePage,
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: RouteName.explorePage,
          name: RouteName.explorePage,
          builder: (context, state) => ExplorePage(),
        ),
        GoRoute(
          path: RouteName.profilePage,
          name: RouteName.profilePage,
          builder: (context, state) => ProfilePage(),
          routes: [
            GoRoute(
              path: RouteName.themeSettingPage,
              name: RouteName.themeSettingPage,
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder:
                  (context, state) =>
                      _customTransitionPage(child: ThemeSettingPage()),
            ),
          ],
        ),
      ],
    ),
  ],
);
