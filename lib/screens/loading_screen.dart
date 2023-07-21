import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';





class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lati =0.0;
  double langi =0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }
  Location location= Location();
  void getLocation()
  async
  {
    await location.getCurrentPosition();
    lati=location.lattitude;
    langi=location.longitude;
    print(lati);
    print(langi);
    getData();
  }
  void getData() async{
    WeatherModel weatherModel = WeatherModel();
    var model= await weatherModel.getWeatherData(lati,langi);
     Navigator.push(context,MaterialPageRoute(builder: (context){
      return LocationScreen(model);
    }));

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child:SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      ),
      ),
    );
  }
}


// var longitude = weatherData['coord']['lon'];
// print(longitude);