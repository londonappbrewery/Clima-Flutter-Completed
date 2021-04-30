//import 'dart:convert';

import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Location loc = new Location();

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    //get the location asynchronously
    get_currentLocation();
  }

  // ignore: non_constant_identifier_names
  Future<void> get_currentLocation() async {
    WeatherModel weatherModel = new WeatherModel();
    //get weather data
    var weatherdata = await weatherModel.get_currentLocation();
    //PUSH THE WEATHER DATA TO THE NEXT SCREEN
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationweather: weatherdata,
      );
    }));
  }

  //fetch data form the inernet

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRipple(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
