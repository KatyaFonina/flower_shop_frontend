import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_switcher.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/bouquet_carousel.dart';
import '../widgets/about_section.dart';
import '../widgets/catalog_grid.dart';
import '../widgets/bouquet_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  int _tabIndex = 0; 

  void _onNavTap(int i) {
    setState(() => _navIndex = i);
    switch (i) {
      case 0:
        break;
      case 1:
        Navigator.of(context).pushNamed('/create');
        break;
      case 2:
        Navigator.of(context).pushNamed('/profile');
        break;
    }
  }

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
              onProfileTap: () => Navigator.of(context).pushNamed('/profile'),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: _Hero()),
                  const SliverToBoxAdapter(child: BouquetCarousel()),
                  const SliverToBoxAdapter(child: AboutSection()),
                  SliverToBoxAdapter(
                    child: BottomSwitcher(
                      onChanged: (i) => setState(() => _tabIndex = i),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _tabIndex == 0
                        ? const CatalogGrid(category: 'flower')
                        : const CatalogGrid(category: 'bouquet'),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -30,
            bottom: -10,
            child: Image.asset(
              'assets/images/hero_tulip.png',
              width: 190,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 60,
            child: Center(
              child: Text(
                'FLOWER SHOP',
                style: AppText.koulen(
                  72,
                  color: AppColors.pinkBtn,
                  letterSpacing: -2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
