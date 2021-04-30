import 'dart:convert';
import 'package:http/http.dart' as http;

class Networking {
  //fetch data from the net
  final String url;
  final String path;
  Map<String, dynamic> query = new Map();
  Networking({this.url,this.path,this.query});
  //double _lat;
  //double _lon;
  var _data; //contains the json data

  //get data form the interent
  Future<dynamic> fetchWeatherData() async {
    http.Response _weatherResponse = await http.get(
        Uri.https(this.url, this.path, this.query));
    if (_weatherResponse.statusCode == 200) {
      _data = _weatherResponse.body;
      //print(weatherResponse.body);
      // var temprature = jsonDecode(data)['main']['temp'];
      // print(temprature);
      // var country = jsonDecode(data)['sys']['country'];
      // print(country);
      // var cityTown = jsonDecode(data)['name'];
      return jsonDecode(_data);
      //print(data);
    } else {
      //indicates the code with error
      return _weatherResponse.statusCode;
    }
  }
}
