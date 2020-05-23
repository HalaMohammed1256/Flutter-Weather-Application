import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class ChartPainter extends CustomPainter {
  final double minTemp, maxTemp;
  ChartPainter({this.minTemp, this.maxTemp});
  @override
  void paint(Canvas canvas, Size size) {
    Paint completedPaint = Paint()
      // ..color = Colors.black12
      ..color = Colors.grey.withAlpha(80)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(50), math.radians(-280), false, completedPaint);
    // canvas.drawCircle(center, size.width / 2, completedPaint);

    Paint linePaint = Paint()
      ..shader = LinearGradient(colors: [
        // Color(0xffc30000),
        // Color(0xffba000d),
        Color(0xffb91400),
        Color(0xffdd2c00),
        Color(0xffff3d00),
        Color(0xfff4511e),
      ]).createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(minTemp - 100),
        math.radians(maxTemp + 10),
        false,
        linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
