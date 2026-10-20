import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/tap_scale.dart';
import '../data/api_client.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            AppHeader(
              onCartTap: () => Navigator.of(context).pushNamed('/cart'),
              onProfileTap: () {}, 
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Image.asset(
                          'assets/images/about_anemone.png',
                          width: 100,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    _MenuButton(
                      icon: Icons.favorite,
                      label: 'FAVORITES',
                      onTap: () =>
                          Navigator.of(context).pushNamed('/favorites'),
                    ),
                    const SizedBox(height: 16),
                    _MenuButton(
                      icon: Icons.chat_bubble,
                      label: 'ONLINE ASSISTANT',
                      onTap: () =>
                          Navigator.of(context).pushNamed('/assistant'),
                    ),
                    const SizedBox(height: 16),
                    _MenuButton(
                      icon: Icons.access_time,
                      label: 'ORDER HISTORY',
                      onTap: () => Navigator.of(context).pushNamed('/orders'),
                    ),
                    const SizedBox(height: 24),
                    TapScale(
                      onTap: () async {
                        await ApiClient.logout();
                        if (!context.mounted) return;
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text('EXIT',
                            style:
                                AppText.koulen(16, color: AppColors.pinkBtn)),
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
        currentIndex: 2,
        onTap: (i) {
          if (i == 0) Navigator.of(context).pushReplacementNamed('/');
          if (i == 1) Navigator.of(context).pushNamed('/create');
          if (i == 2) {} // уже на профиле
        },
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.softPink, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.pinkBtn, size: 24),
            const Spacer(),
            Text(label, style: AppText.koulen(14, color: AppColors.wine)),
          ],
        ),
      ),
    );
  }
}
