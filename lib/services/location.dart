
import 'package:geolocator/geolocator.dart';

class Location {
  //properties
  double longitude;
  double lattitude;

  //methods
  void _goToappSettings() async {
    //go to the apps location settings and allow the user to allow location settings
    await Geolocator.openAppSettings();
    await Geolocator.openLocationSettings();
  }

  Future<void> _getuserpermission() async {
    LocationPermission _permission = await Geolocator.requestPermission();
    // ignore: unrelated_type_equality_checks
    if (_permission == LocationPermission.denied) {
      //get an alert
    }
  }

  Future<void> getLoc() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    try {
      if (isLocationServiceEnabled == true) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        //print(_position);
        this.lattitude = position.latitude;
        this.longitude = position.longitude;
        //print(lattitude);
       
      } else if (isLocationServiceEnabled == false) {
        //tell the user toenable location on the device
        //get permission
        //go to the user settings
        _goToappSettings(); //go to the app settings
        _getuserpermission(); //allow the user to make the permission tote device
        //getLoc();

      }
    } catch (e) {
      print(e);
    }
  }
}
