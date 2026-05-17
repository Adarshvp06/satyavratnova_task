import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  Future<bool> requestLocationPermission() async {
    try {
      final status = await Permission.location.status;
      if (status.isGranted) {
        return true;
      }

      if (status.isPermanentlyDenied) {
        log('Location permission is permanently denied. Opening settings.');
        await openAppSettings();
        return false;
      }

      final result = await Permission.location.request();
      return result.isGranted;
    } catch (e) {
      log('Error requesting location permission: $e');
      return false;
    }
  }

  Future<bool> requestNotificationPermission() async {
    try {
      final status = await Permission.notification.status;
      if (status.isGranted) {
        return true;
      }

      if (status.isPermanentlyDenied) {
        log('Notification permission is permanently denied. Opening settings.');
        await openAppSettings();
        return false;
      }

      final result = await Permission.notification.request();
      return result.isGranted;
    } catch (e) {
      log('Error requesting notification permission: $e');
      return false;
    }
  }

  Future<bool> isLocationPermissionGranted() async {
    try {
      return await Permission.location.isGranted;
    } catch (e) {
      log('Error checking location permission status: $e');
      return false;
    }
  }

  Future<bool> isNotificationPermissionGranted() async {
    try {
      return await Permission.notification.isGranted;
    } catch (e) {
      log('Error checking notification permission status: $e');
      return false;
    }
  }

  Future<bool> openSettings() async {
    try {
      return await openAppSettings();
    } catch (e) {
      log('Error opening app settings: $e');
      return false;
    }
  }
}
