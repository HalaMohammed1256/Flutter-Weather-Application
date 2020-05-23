import './SplashScreenPresenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenPresenter _presenter = SplashScreenPresenter();
  @override
  void initState() {
    super.initState();
    _presenter.getLocationData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafb),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Shimmer.fromColors(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Weather app",
                style: TextStyle(
                  fontSize: 38,
                  fontFamily: 'Pacifico',
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 16,
                      color: Colors.black87,
                      offset: Offset.fromDirection(120, 12),
                    ),
                  ],
                ),
              ),
            ),
            // baseColor: Color(0xff7f00ff),
            // highlightColor: Color(0xffe100ff),
            highlightColor: Color(0xffff3d00),
            baseColor: Colors.grey,
          ),
          SpinKitRing(
            color: Colors.grey,
            size: 55,
          ),
        ],
      ),
    );
  }
}
