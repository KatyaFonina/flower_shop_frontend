import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/cart_data.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/tap_scale.dart';
import '../widgets/top_back_button.dart';

class ResultScreen extends StatefulWidget {
  final String title;
  final int size;
  final List<String> liked;

  const ResultScreen({
    super.key,
    required this.title,
    required this.size,
    required this.liked,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  static const _catalog = [
    ('assets/images/cat_poppy.png', 'POPPY'),
    ('assets/images/cat_craspedia.png', 'CRASPEDIA'),
    ('assets/images/cat_anthurium.png', 'ANTHURIUM'),
    ('assets/images/cat_daffodil.png', 'DAFFODIL'),
    ('assets/images/cat_gerbera.png', 'PINK GERBERA'),
    ('assets/images/cat_tulip.png', 'TULIP'),
    ('assets/images/cat_rose.png', 'ROSE'),
    ('assets/images/cat_gypsophila.png', "BABY'S BREATH"),
    ('assets/images/cat_ranunculus.png', 'RANUNCULUS'),
  ];

  late List<String> _flowers; 

  @override
  void initState() {
    super.initState();
    _flowers = _buildBouquet();
  }

  List<String> _buildBouquet() {
    if (widget.liked.isNotEmpty) {
      return widget.liked.map((name) {
        final match = _catalog.firstWhere(
          (c) => c.$2 == name,
          orElse: () => _catalog[0],
        );
        return match.$1;
      }).toList();
    }
    final rnd = math.Random();
    final count = 3 + rnd.nextInt(3); // 3..5
    final shuffled = List.of(_catalog)..shuffle(rnd);
    return shuffled.take(count).map((c) => c.$1).toList();
  }

  String _nameFromImage(String path) {
    final file = path.split('/').last;
    final base = file.replaceAll('.png', '');
    final name = base.replaceAll('cat_', '');
    return name.toUpperCase();
  }

  void _buy() {
    for (final flower in _flowers) {
      CartData.instance.add(
        CartItem(
          name: _nameFromImage(flower),
          image: flower,
          price: 250,
          qty: 1,
        ),
      );
    }
    Navigator.of(context).pushNamed('/cart');
  }

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
            const SizedBox(height: 20),
            Text('FOR YOU!',
                style: AppText.koulen(28, color: AppColors.wine)),
            const SizedBox(height: 6),
            Text('You can adjust the number\nof flowers in the cart.',
                textAlign: TextAlign.center,
                style: AppText.laila(13, color: AppColors.pinkBtn)),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: Container(
                  width: 240,
                  height: 320,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.softPink.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.pinkBtn.withOpacity(0.35),
                        blurRadius: 30,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: _BouquetView(flowers: _flowers),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TapScale(
              onTap: _buy,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.softPink,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text('buy →',
                    style: AppText.laila(16, color: AppColors.wine)),
              ),
            ),
            const SizedBox(height: 25),
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

class _BouquetView extends StatelessWidget {
  final List<String> flowers;
  const _BouquetView({required this.flowers});

  @override
  Widget build(BuildContext context) {
    final count = flowers.length;
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        return Stack(
          alignment: Alignment.center,
          children: List.generate(count, (i) {
            final angle = (i / count) * 2 * math.pi;
            final dx = math.cos(angle) * w * 0.18;
            final dy = math.sin(angle) * h * 0.18;
            final rot = (i.isEven ? 1 : -1) * (0.15 + i * 0.03);
            return Positioned(
              left: w / 2 + dx - 50,
              top: h / 2 + dy - 50,
              child: Transform.rotate(
                angle: rot,
                child: Image.asset(
                  flowers[i],
                  width: 90,
                  fit: BoxFit.contain,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}