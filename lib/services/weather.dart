
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
String apiKey = '623908ba15a27a787636e10a610a4b9a';
class WeatherModel {
  double latit=0.0;
  double longit=0.0;
  Location location= Location();
 Future<dynamic> getCityWeather( String cityName)async{
    Networking networkhelper = await Networking('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkhelper.func();
    return weatherData;
  }
  Future<dynamic> getWeatherData(latit ,langit) async{
    Networking networkhelper = await Networking('https://api.openweathermap.org/data/2.5/weather?lat=${latit}&lon=${langit}&appid=$apiKey&units=metric');
    var weatherData = await networkhelper.func();
    return weatherData;

  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 35) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for raincoat and umbrella';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
