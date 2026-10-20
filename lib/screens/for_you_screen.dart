import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/tap_scale.dart';

class ForYouScreen extends StatelessWidget {
  const ForYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text('FOR YOU!',
                        style: AppText.koulen(30, color: AppColors.wine)),
                    const SizedBox(height: 8),
                    Text('You can adjust the number\nof flowers in the cart.',
                        textAlign: TextAlign.center,
                        style: AppText.laila(14, color: AppColors.pinkBtn)),
                    const SizedBox(height: 30),
                    Container(
                      width: 220,
                      height: 280,
                      decoration: BoxDecoration(
                        color: AppColors.softPink,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.pinkBtn.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/cat_gerbera.png',
                        width: 140,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TapScale(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.softPink,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text('buy →',
                            style: AppText.laila(16,
                                color: AppColors.wine)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onTap: (i) {},
      ),
    );
  }
}