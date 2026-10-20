import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/about_anemone.png',
            width: 140,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'FLOWER SHOP IS A PLACE WHERE FRESH FLOWERS, '
              'BOUQUETS, AND INDOOR PLANTS ARE SOLD, AND OFTEN '
              'ALSO RELATED PRODUCTS: VASES, GIFT CERTIFICATES, '
              'AND DECORATIVE ITEMS. IN SUCH SHOPS, YOU CAN NOT '
              'ONLY BUY A READY-MADE BOUQUET BUT ALSO ORDER AN '
              'INDIVIDUAL ARRANGEMENT FOR A SPECIAL OCCASION: '
              'WEDDING, BIRTHDAY, AND ANNIVERSARY.',
              style: AppText.laila(
                11,
                color: AppColors.wine,
                weight: FontWeight.w700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}