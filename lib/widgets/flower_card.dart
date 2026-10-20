import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'tap_scale.dart';

class FlowerCard extends StatelessWidget {
  final String image;
  final VoidCallback? onTap;
  const FlowerCard({super.key, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.softPink, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: AppColors.pinkBtn.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Image.asset(image, fit: BoxFit.contain),
        ),
      ),
    );
  }
}