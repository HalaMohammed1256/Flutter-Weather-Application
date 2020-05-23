import 'package:flutter/material.dart';
import '../services/weather.dart';
import '../home/HomeView.dart';

class SplashScreenPresenter {
  void getLocationData(BuildContext context) async {
    var weatherData = await WeatherModel().getLocationWeather();
    await Future.delayed(Duration(milliseconds: 2000));

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Home(
          locationWeather: weatherData,
        ),
      ),
    );
  }
}
