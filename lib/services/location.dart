import 'package:geolocator/geolocator.dart';

class Location {
  double latitude, longitude;

  Future<void> getLocationData() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
