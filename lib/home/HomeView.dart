import 'package:clima_project/home/HomeContract.dart';
import '../services/weather.dart';
import 'package:flutter/material.dart';
import '../weather/WeatherView.dart';

class Home extends StatefulWidget {
  final locationWeather;
  Home({this.locationWeather});
  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> implements HomeContract {
  int tempreture, humidity;
  var condition;
  String cityName, updatedCityName;
  String weatherMessage, description;
  double _screenWidth;
  double windSpeed;
  double _screenHight;
  var _fontScale;
  String icon;
  WeatherModel _weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        tempreture = 0;
        condition = "Error";
        weatherMessage = "Unable to get weather data";
        cityName = "";
      }
      tempreture = (weatherData["main"]["temp"]).toInt();
      condition = weatherData["weather"][0]["id"];
      cityName = weatherData["name"];
      weatherMessage = _weatherModel.getMessage(tempreture);
      icon = weatherData["weather"][0]["icon"];
      description = weatherData["weather"][0]["description"];
      windSpeed = weatherData["wind"]["speed"];
      humidity = (weatherData["main"]["humidity"]).toInt();
      print("$tempreture");
    });
  }

  @override
  Widget build(BuildContext context) {
    _screenHight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    _fontScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      backgroundColor: Color(0xfffafafb),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: _screenHight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: _screenHight * 0.03),
                child: Text(
                  "Weather",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Pacifico",
                      fontSize: _fontScale * 20),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  var weatherData = await WeatherModel().getLocationWeather();
                  updateUI(weatherData);
                },
                child: Icon(
                  Icons.refresh,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(_screenHight * 0.0074),
            margin: EdgeInsets.fromLTRB(_screenHight * 0.04,
                _screenHight * 0.059, _screenHight * 0.04, _screenHight * 0.2),
            decoration: BoxDecoration(
              color: Color(0xffe5e7ea),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                icon: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  onPressed: () async {
                    // await Future.delayed(Duration(milliseconds: 3000));
                    var enteredCity = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WeatherPage(
                          cityName: updatedCityName,
                        ),
                      ),
                    );

                    if (enteredCity != null) {
                      var weatherData =
                          await _weatherModel.getCityWeather(enteredCity);
                      updateUI(weatherData);
                    }
                  },
                ),
                hintText: "Enter city name",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onChanged: (String value) {
                setState(() {
                  updatedCityName = value;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                '$tempreture',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: _fontScale * 60,
                ),
              ),
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 2),
                    child: Text(
                      '°',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: _fontScale * 60,
                      ),
                    ),
                  ),
                  Text(
                    'C',
                    style: TextStyle(
                        color: Colors.grey.withAlpha(80), //Color(0xffdedfe2)
                        fontSize: _fontScale * 60,
                        fontFamily: "Pacifico"), //EmblemaOne   Amita  Pacifico
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Image.network(
                "http://openweathermap.org/img/wn/$icon@2x.png",
              )
            ],
          ),
          Text(
            "$description",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Amita",
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: _screenHight * 0.0439,
          ),
          Text(
            "Wind Speed: $windSpeed km/h",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Amita",
              fontSize: _fontScale * 18,
            ),
          ),
          Text(
            "Humidity: $humidity %",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Amita",
              fontSize: _fontScale * 18,
            ),
          ),
          Text(
            "$cityName",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Amita",
              fontSize: _fontScale * 18,
            ),
          )
        ],
      ),
    );
  }
}
