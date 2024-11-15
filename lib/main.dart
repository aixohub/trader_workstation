import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: RotatingConcentricCircles(),
        ),
      ),
    );
  }
}

class RotatingConcentricCircles extends StatefulWidget {
  @override
  _RotatingConcentricCirclesState createState() =>
      _RotatingConcentricCirclesState();
}

class _RotatingConcentricCirclesState extends State<RotatingConcentricCircles> {
  double innerAngle = 0;
  double middleAngle = 0;
  double outerAngle = 0;
  double fourAngle = 0;

  void _rotateFirst(DragUpdateDetails details) {
    setState(() {
      innerAngle += details.delta.dx * 0.01;
    });
  }

  void _rotateSecond(DragUpdateDetails details) {
    setState(() {
      middleAngle += details.delta.dx * 0.01;
    });
  }

  void _rotateThird(DragUpdateDetails details) {
    setState(() {
      outerAngle += details.delta.dx * 0.01;
    });
  }

  void _rotateFour(DragUpdateDetails details) {
    setState(() {
      fourAngle += details.delta.dx * 0.01;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onPanUpdate: _rotateFour,
              child: Transform.rotate(
                angle: fourAngle,
                child: CustomPaint(
                  size: Size(800, 800),
                  painter:
                  RingPainter(["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛"]),
                ),
              ),
            ),
            GestureDetector(
              onPanUpdate: _rotateThird,
              child: Transform.rotate(
                angle: outerAngle,
                child: CustomPaint(
                  size: Size(600, 600),
                  painter:
                  RingPainter(["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛"]),
                ),
              ),
            ),
            GestureDetector(
              onPanUpdate: _rotateSecond,
              child: Transform.rotate(
                angle: middleAngle,
                child: CustomPaint(
                  size: Size(400, 400),
                  painter:
                  RingPainter(["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛"]),
                ),
              ),
            ),
            GestureDetector(
              onPanUpdate: _rotateFirst,
              child: Transform.rotate(
                angle: innerAngle,
                child: CustomPaint(
                  size: Size(200, 200),
                  painter:
                  RingPainter(["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛"]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class RingPainter extends CustomPainter {
  final List<String> labels;

  RingPainter(this.labels);

  @override
  void paint(Canvas canvas, Size size) {
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius -100;
    final center = Offset(size.width / 2, size.height / 2);
    final elements = labels;
    final sweepAngle = 2 * pi / elements.length;

    // Paint for outer and inner rings
    final ringPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerRadius - innerRadius;

    // Draw outer and inner rings
    canvas.drawCircle(center, (outerRadius + innerRadius) / 2, ringPaint);

    for (int i = 0; i < elements.length; i++) {
      final startAngle = i * sweepAngle;

      // Draw each segment
      final segmentPaint = Paint()
        ..color = Colors.primaries[i % Colors.primaries.length].withOpacity(0.3)
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: outerRadius),
        startAngle,
        sweepAngle,
        true,
        segmentPaint,
      );

      // Draw text in each segment
      final textPainter = TextPainter(
        text: TextSpan(
          text: elements[i],
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Calculate position for each text
      final textAngle = startAngle + sweepAngle / 2;
      final textOffset = Offset(
        center.dx +
            (outerRadius + innerRadius) / 2 * cos(textAngle) -
            textPainter.width / 2,
        center.dy +
            (outerRadius + innerRadius) / 2 * sin(textAngle) -
            textPainter.height / 2,
      );

      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
