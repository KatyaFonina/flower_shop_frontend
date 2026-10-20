import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/tap_scale.dart';
import '../widgets/top_back_button.dart';

class ChooseFavoritesScreen extends StatefulWidget {
  const ChooseFavoritesScreen({super.key});

  @override
  State<ChooseFavoritesScreen> createState() => _ChooseFavoritesScreenState();
}

class _ChooseFavoritesScreenState extends State<ChooseFavoritesScreen> {
  static const _allFlowers = [
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

  int _index = 0;
  final List<String> _liked = [];

  void _swipe(bool like) {
    if (like) _liked.add(_allFlowers[_index].$2);
    setState(() => _index++);
  }

  @override
  Widget build(BuildContext context) {
    final done = _index >= _allFlowers.length;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            const TopBackButton(),
            const SizedBox(height: 10),

            Text('CHOOSE FAVORITES',
                style: AppText.koulen(24, color: AppColors.pinkBtn)),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('← i dont',
                      style: AppText.laila(14, color: AppColors.wine)),
                  Text('i like →',
                      style: AppText.laila(14, color: AppColors.wine)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: done
                  ? Center(
                      child: Text('Все цветы просмотрены!',
                          style: AppText.laila(14,
                              color: AppColors.wine)),
                    )
                  : _SwipeCard(
                      key: ValueKey(_index),
                      image: _allFlowers[_index].$1,
                      onSwipeLeft: () => _swipe(false),
                      onSwipeRight: () => _swipe(true),
                    ),
            ),

            const SizedBox(height: 20),
            TapScale(
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/result',
                  arguments: {
                    'title': 'your bouquet',
                    'size': _liked.isEmpty ? 15 : _liked.length * 5,
                    'liked': _liked,
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.softPink,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text('create',
                    style: AppText.laila(15, color: AppColors.wine)),
              ),
            ),
            const SizedBox(height: 20),
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


class _SwipeCard extends StatefulWidget {
  final String image;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  const _SwipeCard({
    super.key,
    required this.image,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  });

  @override
  State<_SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<_SwipeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  Offset _drag = Offset.zero;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _endDrag(DragEndDetails d) {
    final v = d.velocity.pixelsPerSecond.dx;
    if (_drag.dx > 80 || v > 500) {
      widget.onSwipeRight();
    } else if (_drag.dx < -80 || v < -500) {
      widget.onSwipeLeft();
    } else {
      setState(() => _drag = Offset.zero);
    }
  }

  @override
  Widget build(BuildContext context) {
    final angle = _drag.dx / 800;

    return GestureDetector(
      onPanUpdate: (d) => setState(() => _drag += d.delta),
      onPanEnd: _endDrag,
      child: Transform.translate(
        offset: _drag,
        child: Transform.rotate(
          angle: angle,
          child: Container(
            width: 240,
            height: 320,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.pinkBtn, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.mint.withOpacity(0.4),
                  blurRadius: 30,
                  spreadRadius: 4,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(widget.image, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}