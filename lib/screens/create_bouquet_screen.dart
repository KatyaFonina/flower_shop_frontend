import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/tap_scale.dart';

class CreateBouquetScreen extends StatefulWidget {
  const CreateBouquetScreen({super.key});

  @override
  State<CreateBouquetScreen> createState() => _CreateBouquetScreenState();
}

class _CreateBouquetScreenState extends State<CreateBouquetScreen> {
  int _navIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: -50,
              left: -50,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset('assets/images/bg_flower.png', width: 180),
              ),
            ),
            Positioned(
              bottom: -50,
              right: -50,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset('assets/images/bg_flower.png', width: 220),
              ),
            ),

            Column(
              children: [
                AppHeader(
  onCartTap: () => Navigator.of(context).pushNamed('/cart'),
  onProfileTap: () => Navigator.of(context).pushNamed('/profile'),
),
                const Spacer(),
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.pinkBtn,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'create\nyour\nbouquet',
                      textAlign: TextAlign.center,
                      style: AppText.laila(
                        22,
                        color: AppColors.white,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TapScale(
                  onTap: () => Navigator.of(context).pushNamed('/choose-situation'),
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC96A6A),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.add,
                        color: AppColors.white, size: 28),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: (i) {
          setState(() => _navIndex = i);
          if (i == 0) Navigator.of(context).pushReplacementNamed('/');
          if (i == 2) Navigator.of(context).pushNamed('/profile');
        },
      ),
    );
  }
}