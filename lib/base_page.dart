import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onboarding_app/core/router_config/route_name.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key, required this.child});
  final Widget child;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          context.go(_convertIndexIntoRouteName(index));
        },
        currentIndex: () {
          final String currentUri = GoRouterState.of(context).uri.toString();
          return _convertRouteNameIntoIndex(currentUri);
        }(),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  String _convertIndexIntoRouteName(int index) {
    switch (index) {
      case 0:
        return RouteName.homePage;
      case 1:
        return RouteName.explorePage;
      case 2:
        return RouteName.profilePage;
      default:
        return RouteName.homePage;
    }
  }

  int _convertRouteNameIntoIndex(String pathName) {
    if (pathName.startsWith(RouteName.homePage)) {
      return 0;
    } else if (pathName.startsWith(RouteName.explorePage)) {
      return 1;
    } else if (pathName.startsWith(RouteName.profilePage)) {
      return 2;
    } else {
      return 0;
    }
  }
}
