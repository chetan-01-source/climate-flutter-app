import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen(this.wdata);
  var wdata;
  int temperature = 0;
  String weatherIcon='';
  String msg ='';
  String City ='';

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double latitu=0;
  double langitu=0;
  String cityName='';
  @override
  WeatherModel weather = WeatherModel();
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUi(widget.wdata);

    }
    void updateUi(wdata){
     setState(() {
       if(wdata==null){
         widget.temperature=0;
         widget.City='Null';
         widget.msg='error';
       }
       double temp= wdata['main']['temp'];
       widget.temperature = temp.toInt();
       widget.City= wdata['name'];
       var condition=wdata['weather'][0]['id'];
       widget.weatherIcon=weather.getWeatherIcon(condition);
       widget.msg=weather.getMessage(widget.temperature);
     });
    }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      Location locat =Location();
                       await locat.getCurrentPosition();
                      latitu=locat.lattitude;
                      langitu=locat.longitude;
                      print(latitu);
                      print(langitu);
                      WeatherModel wmodeldata = WeatherModel();
                      var weatherData= await wmodeldata.getWeatherData(latitu,langitu);
                      print(weatherData);
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName= await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      print(typedName);
                      if(typedName!=null){
                        cityName=typedName;
                        var wdta = await weather.getCityWeather(typedName);
                        print(wdta);
                        updateUi(wdta);

                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${widget.temperature}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '${widget.weatherIcon}',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '${widget.msg } in  ${widget.City}',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
