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
                  painter: RingPainterFour(),
                ),
              ),
            ),
            GestureDetector(
              onPanUpdate: _rotateThird,
              child: Transform.rotate(
                angle: outerAngle,
                child: CustomPaint(
                  size: Size(600, 600),
                  painter: RingPainterThird(),
                ),
              ),
            ),
            GestureDetector(
              onPanUpdate: _rotateSecond,
              child: Transform.rotate(
                angle: middleAngle,
                child: CustomPaint(
                  size: Size(400, 400),
                  painter: RingPainterSecond(
                      ["柱", "心", "蓬", "任", "冲", "辅", "英", "禽芮"]),
                ),
              ),
            ),
            GestureDetector(
              onPanUpdate: _rotateFirst,
              child: Transform.rotate(
                angle: innerAngle,
                child: CustomPaint(
                  size: Size(200, 200),
                  painter: RingPainterFirst(
                      ["真符", "九天", "九地", "玄武", "白虎", "六和", "太阴", "腾蛇"]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 神盘
class RingPainterFirst extends CustomPainter {
  final List<String> labels;

  RingPainterFirst(this.labels);

  @override
  void paint(Canvas canvas, Size size) {
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius - 100;
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
        ..color = Colors.primaries[i % 4].withOpacity(0.3)
        ..style = PaintingStyle.stroke;

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

      // Calculate the position for text
      final textAngle = startAngle + sweepAngle / 2;
      final textRadius = (outerRadius + innerRadius) / 2;
      final textPosition = Offset(
        center.dx + textRadius * cos(textAngle),
        center.dy + textRadius * sin(textAngle),
      );

      // Save canvas state
      canvas.save();

      // Move canvas to text position and rotate it
      canvas.translate(textPosition.dx, textPosition.dy);
      canvas.rotate(textAngle - pi / 2); // Adjust for bottom to face center

      // Draw the text centered horizontally
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      // Restore canvas state
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// 天盘
class RingPainterSecond extends CustomPainter {
  final List<String> labels;

  RingPainterSecond(this.labels);

  @override
  void paint(Canvas canvas, Size size) {
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius - 100;
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
        ..color = Colors.primaries[i % 4].withOpacity(0.3)
        ..style = PaintingStyle.stroke;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: outerRadius),
        startAngle,
        sweepAngle,
        true,
        segmentPaint,
      );

      // 计算文本的旋转角度，使文字顶部朝向圆心
      // Draw text in each segment
      final textPainter = TextPainter(
        text: TextSpan(
          text: elements[i],
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Calculate the position for text
      final textAngle = startAngle + sweepAngle / 2;
      final textRadius = (outerRadius + innerRadius) / 2;
      final textPosition = Offset(
        center.dx + textRadius * cos(textAngle),
        center.dy + textRadius * sin(textAngle),
      );

      // Save canvas state
      canvas.save();

      // Move canvas to text position and rotate it
      canvas.translate(textPosition.dx, textPosition.dy);
      canvas.rotate(textAngle - pi / 2); // Adjust for bottom to face center

      // Draw the text centered horizontally
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      // Restore canvas state
      canvas.restore();

    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// 人
class RingPainterThird extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius - 100;
    final center = Offset(size.width / 2, size.height / 2);
    final elements = ["惊", "开", "休", "生", "伤", "杜", "景", "死"];
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
        ..color = Colors.primaries[i % 4].withOpacity(0.3)
        ..style = PaintingStyle.stroke;

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

      // Calculate the position for text
      final textAngle = startAngle + sweepAngle / 2;
      final textRadius = (outerRadius + innerRadius) / 2;
      final textPosition = Offset(
        center.dx + textRadius * cos(textAngle),
        center.dy + textRadius * sin(textAngle),
      );

      // Save canvas state
      canvas.save();

      // Move canvas to text position and rotate it
      canvas.translate(textPosition.dx, textPosition.dy);
      canvas.rotate(textAngle - pi / 2); // Adjust for bottom to face center

      // Draw the text centered horizontally
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      // Restore canvas state
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// 地
class RingPainterFour extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius - 100;
    final center = Offset(size.width / 2, size.height / 2);
    final elements = ["兑七", "乾六", "坎一", "艮八", "震三", "巽四", "离九", "坤二"];
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
        ..style = PaintingStyle.stroke;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: outerRadius),
        startAngle,
        sweepAngle,
        true,
        segmentPaint,
      );

      // Prepare text
      final textPainter = TextPainter(
        text: TextSpan(
          text: elements[i],
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Calculate the position for text
      final textAngle = startAngle + sweepAngle / 2;
      final textRadius = (outerRadius + innerRadius) / 2;
      final textPosition = Offset(
        center.dx + textRadius * cos(textAngle),
        center.dy + textRadius * sin(textAngle),
      );

      // Save canvas state
      canvas.save();

      // Move canvas to text position and rotate it
      canvas.translate(textPosition.dx, textPosition.dy);
      canvas.rotate(textAngle - pi / 2); // Adjust for bottom to face center

      // Draw the text centered horizontally
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      // Restore canvas state
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
