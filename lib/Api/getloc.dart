import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class getloc{
  String location ='Null';
  String Address = 'Null';



  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];
    Address = '${place.locality}';
  }
}