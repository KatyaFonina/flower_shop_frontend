import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'tap_scale.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 60,
              color: AppColors.pinkBtn,
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  _buildIcon(
                    index: 0,
                    icon: Icons.home_outlined,
                    current: currentIndex,
                    onTap: onTap,
                  ),
                  _buildIcon(
                    index: 1,
                    icon: Icons.star,
                    current: currentIndex,
                    onTap: onTap,
                  ),
                  _buildIcon(
                    index: 2,
                    icon: Icons.person_outline,
                    current: currentIndex,
                    onTap: onTap,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon({
    required int index,
    required IconData icon,
    required int current,
    required ValueChanged<int> onTap,
  }) {
    final active = index == current;

    if (active) {
      return Expanded(
        child: Align(
          alignment: Alignment.topCenter,
          child: Transform.translate(
            offset: const Offset(0, -22), 
            child: TapScale(
              onTap: () => onTap(index),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.pinkBtn,      
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.cream,      
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: AppColors.white, size: 26),
              ),
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: TapScale(
          onTap: () => onTap(index),
          child: Icon(icon, color: AppColors.white, size: 26),
        ),
      ),
    );
  }
}