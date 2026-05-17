import 'package:flutter/material.dart';

import '../../../core/services/location_service.dart';
import '../../../core/services/permission_service.dart';
import '../model/navigation_tab.dart';

class NavigationViewModel extends ChangeNotifier {
  final PermissionService _permissionService;
  final LocationService _locationService;
  NavigationTab _currentTab = NavigationTab.home;
  String _currentCity = "";

  NavigationViewModel({
    required PermissionService permissionService,
    required LocationService locationService,
  })  : _permissionService = permissionService,
        _locationService = locationService {
    _init();
  }

  String get currentCity => _currentCity;

  Future<void> _init() async {
    await _permissionService.requestNotificationPermission();

   await _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    final city = await _locationService.getCurrentCity();
    if (_currentCity != city) {
      _currentCity = city;
      notifyListeners();
    }
  }

  NavigationTab get currentTab => _currentTab;

  void setTab(NavigationTab tab) {
    if (_currentTab != tab) {
      _currentTab = tab;
      notifyListeners();
    }
  }

  int get currentIndex => _currentTab.index;
  void setIndex(int index) {
    if (index >= 0 && index < NavigationTab.values.length) {
      setTab(NavigationTab.values[index]);
    }
  }
}
