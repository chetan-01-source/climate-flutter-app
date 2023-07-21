import 'package:geolocator/geolocator.dart';

class Location{
   double lattitude=0;
  double longitude=0;
  Future<void> getCurrentPosition()async{
    try{
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      lattitude=position.latitude;
      longitude=position.longitude;
    }
    catch(e) {
      print(e);
    }
  }
}