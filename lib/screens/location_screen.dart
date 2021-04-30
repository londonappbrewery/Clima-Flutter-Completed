import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = new WeatherModel(); //weather model instance
  int temprature;
  String country;
  String cityTown;
  int condition;
  String weathermsg;
  String weatherIcon;
  @override
  void initState() {
    super.initState();
    updateWeatherInfo(widget.locationweather);
  }

  void updateWeatherInfo(var weatherdatainfo) {
    // if (weatherdatainfo == null) {
    //   this.temprature = 0;
    //   this.cityTown = '';
    //   this.country = '';
    //   return;
    // }
    //decoding the jsin data

    double temp = weatherdatainfo['main']['temp'];
    temprature = temp.toInt(); //convert to an int
    weathermsg = weatherModel.getMessage(temprature); //displaye message
    //weatherIcon = weatherModel.getWeatherIcon(condition);//get icon
    country = weatherdatainfo['sys']['country'];
    cityTown = weatherdatainfo['name'];
    condition = weatherdatainfo['weather'][0]['id'];

    print(temprature);
    print(country);
    print(cityTown);
    print(condition);
  }

  @override
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
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () async{
                      var weatherdata = await weatherModel.get_currentLocation();
                      setState(() {
                        updateWeatherInfo(weatherdata);

                      });
                      
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () async {
                      var typedCityName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      print(typedCityName);
                      if (typedCityName != null) {
                        //call a function and get the weather

                        //WeatherModel weathermodel = new WeatherModel();
                        var newweatherdata = await weatherModel
                            .fetchWeatherDataByCityName(typedCityName);
                        setState(() {
                          updateWeatherInfo(newweatherdata);
                        });    
                        
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
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.temperatureHigh),
                        Text(
                          '$temprature',
                          style: kTempTextStyle,
                        ),
                      ],
                    ),
                    Text(
                      weatherModel.getWeatherIcon(condition),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Center(
                  child: Text(
                    '$weathermsg' + 'in' + '' + '' + '$cityTown',
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
