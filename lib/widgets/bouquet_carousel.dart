import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'bouquet_card.dart';

class BouquetCarousel extends StatelessWidget {
  const BouquetCarousel({super.key});

  static const _items = [
    (
      'BYE WINTER',
      '5699p.',
      'assets/images/bouquet_bye_winter.png',
      'This bouquet is a warm farewell to winter: dense greens, '
          'bright red accents and lush peony-shaped buds. Perfect for '
          'those who love rich, textured compositions.',
    ),
    (
      '8TH MARCH',
      '5699p.',
      'assets/images/bouquet_8th_march.png',
      'This dopamine bouquet is not only a great holiday gift '
          'but also will brighten up your home with its vibrant colors!',
    ),
    (
      'SUNRISE',
      '5699p.',
      'assets/images/bouquet_sunrise.png',
      'Pastel ranunculus, delicate tulips and a touch of blue — '
          'a gentle morning mood captured in a bouquet. Ideal for '
          'romantic and calm occasions.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.pinkLight, AppColors.pinkGrad],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    'spring vibe',
                    style: AppText.laila(10, color: AppColors.cream),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'new bouquets',
                      style: AppText.koulen(20, color: AppColors.cream),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    'you will love it',
                    textAlign: TextAlign.right,
                    style: AppText.laila(10, color: AppColors.cream),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: _items.map((item) {
                final isActive = item.$1 == '8TH MARCH';
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: BouquetCard(
                      title: item.$1,
                      price: item.$2,
                      image: item.$3,
                      active: isActive,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/detail',
                          arguments: {
                            'title': item.$1,
                            'price': item.$2,
                            'image': item.$3,
                            'description': item.$4,
                          },
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}