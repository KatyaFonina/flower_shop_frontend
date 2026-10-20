import 'package:flutter/material.dart';

class BackgroundFlower extends StatelessWidget {
  final Widget child;
  const BackgroundFlower({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -80,
          left: -80,
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              'assets/images/bg_flower.png',
              width: 220,
            ),
          ),
        ),
        Positioned(
          bottom: -80,
          right: -80,
          child: Opacity(
            opacity: 0.5,
            child: Transform.rotate(
              angle: 3.14, // 180°
              child: Image.asset(
                'assets/images/bg_flower.png',
                width: 260,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}