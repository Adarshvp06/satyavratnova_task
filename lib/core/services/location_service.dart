import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'permission_service.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  final PermissionService _permissionService = PermissionService();

  Future<String> getCurrentCity() async {
    try {
      bool hasPermission = await _permissionService.requestLocationPermission();
      if (!hasPermission) {
        log('Location permission not granted.');
        return "N/A";
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log('Location services are disabled.');
        return "N/A";
      }

      Position position = await Geololocator_getCurrentPosition();
      
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final city = place.locality ?? place.subAdministrativeArea ?? place.administrativeArea ?? "Mumbai";
        log('Fetched current city: $city');
        return city.isNotEmpty ? city : "N/A";
      }

      return "N/A";
    } catch (e) {
      log('Error fetching current city: $e');
      return "N/A";
    }
  }

  // ignore: non_constant_identifier_names
  Future<Position> Geololocator_getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
