import 'package:clima/screens/loading_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

class WeatherModel {
  double _latt;
  double _long;
  var weatherdata;
  Future<dynamic> fetchWeatherDataByCityName(String cityname) async {
    Networking netcity = Networking(
        url: 'api.openweathermap.org',
        path: '/data/2.5/weather',
        query: {'q': '$cityname', 'appid': '$apiKey', 'units': 'metric'});
    return weatherdata = await netcity.fetchWeatherData();
    //return weatherdata;
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> get_currentLocation() async {
    await loc.getLoc();
    _latt = loc.lattitude;
    _long = loc.longitude;
    //getweather data in json format
    //fetchjsonweatherdata();
    Networking net = Networking(
        url: 'api.openweathermap.org',
        path: '/data/2.5/weather',
        query: {
          'lat': '$_latt',
          'lon': '$_long',
          'appid': '$apiKey',
          'units': 'metric'
        });
    //wait as it fetches the data
    return weatherdata = await net.fetchWeatherData();
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
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case you are ';
    }
  }
}
