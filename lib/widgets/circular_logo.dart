import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CircularLogo extends StatelessWidget {
  final double size;
  const CircularLogo({super.key, this.size = 200});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/login_flower.png',
            width: size * 0.5,
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _CircularTextPainter(
                text: 'FLOWER SHOP   FLOWER SHOP   FLOWER SHOP   ',
                style: AppText.koulen(
                  size * 0.075,
                  color: AppColors.pinkBtn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularTextPainter extends CustomPainter {
  final String text;
  final TextStyle style;
  _CircularTextPainter({required this.text, required this.style});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 12;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final totalChars = text.length;
    final anglePerChar = (math.pi * 2) / totalChars;

    for (int i = 0; i < totalChars; i++) {
      final char = text[i];
      final angle = anglePerChar * i - math.pi / 2;

      textPainter.text = TextSpan(text: char, style: style);
      textPainter.layout();

      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle + math.pi / 2);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}