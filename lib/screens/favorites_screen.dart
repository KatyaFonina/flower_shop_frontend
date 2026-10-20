import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/favorites_data.dart';
import '../data/cart_data.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/tap_scale.dart';
import '../widgets/top_back_button.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            const TopBackButton(),
            Expanded(
              child: ValueListenableBuilder<List<FavItem>>(
                valueListenable: FavoritesData.instance.items,
                builder: (_, list, __) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text('FAVORITES',
                            style: AppText.koulen(28,
                                color: AppColors.wine)),
                        const SizedBox(height: 30),

                        if (list.isEmpty)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 60),
                            child: Center(
                              child: Text(
                                'No favorites yet',
                                style: AppText.laila(14,
                                    color: AppColors.wine),
                              ),
                            ),
                          ),

                        ...list.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _FavCard(item: item),
                            )),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onTap: (i) {
          if (i == 0) Navigator.of(context).pushReplacementNamed('/');
          if (i == 1) Navigator.of(context).pushNamed('/create');
          if (i == 2) Navigator.of(context).pushNamed('/profile');
        },
      ),
    );
  }
}

class _FavCard extends StatelessWidget {
  final FavItem item;
  const _FavCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.mint, width: 1.5),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: AppColors.pinkBtn.withOpacity(0.5)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset(item.image, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(item.name,
                style: AppText.koulen(13, color: AppColors.wine)),
          ),
          TapScale(
            onTap: () {
              // Добавить в корзину
              CartData.instance.add(CartItem(
                name: item.name,
                image: item.image,
                price: item.price,
              ));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to cart'),
                  duration: Duration(milliseconds: 800),
                ),
              );
            },
            child: Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: AppColors.pinkBtn,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add,
                  color: AppColors.white, size: 20),
            ),
          ),
          const SizedBox(width: 8),
          TapScale(
            onTap: () => FavoritesData.instance.toggle(item),
            child: const Icon(Icons.favorite,
                color: AppColors.pinkBtn, size: 26),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}