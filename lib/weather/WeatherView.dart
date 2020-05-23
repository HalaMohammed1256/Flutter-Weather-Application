import 'package:clima_project/utilities/chartPainter.dart';
import 'package:flutter/material.dart';
import '../services/weather.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  final String cityName;
  WeatherPage({this.cityName});
  @override
  State createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  int tempreture, humidity;
  var condition;
  var _screenHight, _screenWidth, _fontScale;
  String cityName, weatherMessage;
  String date, icon, description;
  double windSpeed;
  double minTemp, maxTemp;

  WeatherModel _weatherModel = WeatherModel();
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    getCityData();
  }

  void getCityData() async {
    var weatherData = await _weatherModel.getCityWeather(widget.cityName);
    setState(() {
      tempreture = (weatherData["main"]["temp"]).toInt();
      condition = weatherData["weather"][0]["id"];
      cityName = weatherData["name"];
      weatherMessage = _weatherModel.getMessage(tempreture);
      icon = weatherData["weather"][0]["icon"];
      description = weatherData["weather"][0]["description"];
      windSpeed = weatherData["wind"]["speed"];
      humidity = (weatherData["main"]["humidity"]).toInt();
      minTemp = weatherData["main"]["temp_min"];
      maxTemp = weatherData["main"]["temp_max"];

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfffafafb),
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "${widget.cityName.toUpperCase()}",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Amita",
                fontSize: _fontScale * 20,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "${DateFormat.MMMMEEEEd().format(dateTime)}",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Amita",
                fontSize: _fontScale * 17),
          ),
          SizedBox(
            height: _screenHight * 0.0292,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                '$tempreture', //°
                style: TextStyle(
                  color: Colors.black,
                  fontSize: _fontScale * 60,
                ), //EmblemaOne   Amita
              ),
              Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: _screenHight * 0.0292,
                        bottom: _screenHight * 0.00292),
                    child: Text(
                      '°',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: _fontScale * 60,
                      ), //EmblemaOne   Amita
                    ),
                  ),
                  Text(
                    'C',
                    style: TextStyle(
                        color: Colors.grey.withAlpha(80), //Color(0xffdedfe2)
                        fontSize: _fontScale * 60,
                        fontFamily: "Pacifico"), //EmblemaOne   Amita
                  ),
                ],
              ),
              SizedBox(
                width: _screenHight * 0.0585,
              ),
              Image.network(
                "http://openweathermap.org/img/wn/$icon@2x.png",
              )
            ],
          ),
          CustomPaint(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              width: _screenHight * 0.234,
              height: _screenHight * 0.234,
            ),
            painter: ChartPainter(minTemp: minTemp, maxTemp: maxTemp),
          ),
          Text(
            "$description",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Amita",
              fontSize: 22,
              // fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: _screenHight * 0.0439,
          ),
          Text(
            "Wind Speed: $windSpeed km/h",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Amita",
              fontSize: _fontScale * 17,
              // fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Humidity: $humidity %",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Amita",
              fontSize: _fontScale * 17,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
