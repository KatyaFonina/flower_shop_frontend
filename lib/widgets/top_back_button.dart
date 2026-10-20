import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'tap_scale.dart';

class TopBackButton extends StatelessWidget {
  const TopBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          TapScale(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 52,
              height: 26,
              decoration: BoxDecoration(
                color: AppColors.softPink,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.arrow_back,
                  size: 16, color: AppColors.wine),
            ),
          ),
        ],
      ),
    );
  }
}