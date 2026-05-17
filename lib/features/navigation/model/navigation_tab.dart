import 'package:flutter/material.dart';

import '../../brand/view/brand_screen.dart';
import '../../create/view/create_screen.dart';
import '../../home/view/homesceen.dart';
import '../../notification/view/notification_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../../search/view/search_screen.dart';
import '../../video/view/video_screen.dart';

enum NavigationTab {
  home,
  search,
  brand,
  create,
  video,
  notification,
  profile;

  Widget get body {
    switch (this) {
      case NavigationTab.home:
        return const HomeScreen();
      case NavigationTab.search:
        return const SearchScreen();
      case NavigationTab.brand:
        return const BrandScreen();
      case NavigationTab.create:
        return const CreateScreen();
      case NavigationTab.video:
        return const VideoScreen();
      case NavigationTab.notification:
        return const NotificationScreen();
      case NavigationTab.profile:
        return const ProfileScreen();
    }
  }

  IconData get icon {
    switch (this) {
      case NavigationTab.home:
        return Icons.home_outlined;
      case NavigationTab.search:
        return Icons.search;
      case NavigationTab.brand:
        return Icons.car_crash;
      case NavigationTab.create:
        return Icons.add;
      case NavigationTab.video:
        return Icons.play_circle_outline;
      case NavigationTab.notification:
        return Icons.notifications_none;
      case NavigationTab.profile:
        return Icons.person_outline;
    }
  }

  IconData get activeIcon {
    switch (this) {
      case NavigationTab.home:
        return Icons.home_filled;
      case NavigationTab.search:
        return Icons.search;
      case NavigationTab.brand:
        return Icons.car_crash;
      case NavigationTab.create:
        return Icons.add;
      case NavigationTab.video:
        return Icons.play_circle_outline;
      case NavigationTab.notification:
        return Icons.notifications;
      case NavigationTab.profile:
        return Icons.person;
    }
  }

  String get label {
    switch (this) {
      case NavigationTab.home:
        return "Home";
      case NavigationTab.search:
        return "Search";
      case NavigationTab.brand:
        return "Brand";
      case NavigationTab.create:
        return "Create";
      case NavigationTab.video:
        return "Video";
      case NavigationTab.notification:
        return "Notifications";
      case NavigationTab.profile:
        return "Profile";
    }
  }
}
