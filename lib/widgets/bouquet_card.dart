import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'tap_scale.dart';

class BouquetCard extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final bool active;
  final VoidCallback? onTap;

  const BouquetCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TapScale(
          onTap: onTap,
          child: AspectRatio(
            aspectRatio: 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: AppColors.cream,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(80),
                  topRight: Radius.circular(80),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: AppColors.mint.withOpacity(0.8),
                          blurRadius: 30,
                          spreadRadius: 4,
                        ),
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text('"$title"',
            style: AppText.koulen(14, color: AppColors.cream),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        const SizedBox(height: 2),
        Text(price, style: AppText.laila(12, color: AppColors.wine)),
        const SizedBox(height: 6),
        TapScale(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.cream, width: 1.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('BUY',
                style: AppText.laila(11, color: AppColors.cream)),
          ),
        ),
      ],
    );
  }
}