import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/tap_scale.dart';
import '../widgets/circular_logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -60,
              right: -60,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.6,
                  child: Image.asset('assets/images/bg_flower.png',
                      width: 220),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -60,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.6,
                  child: Transform.rotate(
                    angle: 3.14159,
                    child: Image.asset('assets/images/bg_flower.png',
                        width: 260),
                  ),
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularLogo(size: 220),
                  const SizedBox(height: 80),

                  TapScale(
                    onTap: () {
                      debugPrint('LOG IN tapped');
                      Navigator.of(context).pushNamed('/login-form');
                    },
                    child: Container(
                      width: 240,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.softPink,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'LOG IN',
                        style: AppText.laila(
                          14,
                          color: AppColors.wine,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TapScale(
                    onTap: () {
                      debugPrint('registration tapped');
                      Navigator.of(context).pushNamed('/registration');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.softPink.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'registration',
                        style: AppText.laila(12,
                            color: AppColors.wine.withOpacity(0.8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}