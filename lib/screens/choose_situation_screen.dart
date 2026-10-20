import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/tap_scale.dart';
import '../widgets/top_back_button.dart';

class ChooseSituationScreen extends StatelessWidget {
  const ChooseSituationScreen({super.key});

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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 6),
                    Text('CHOOSE YOUR',
                        textAlign: TextAlign.center,
                        style: AppText.koulen(
                          30,
                          color: AppColors.pinkBtn.withOpacity(0.75),
                          letterSpacing: 1,
                        )),
                    Text('situation',
                        textAlign: TextAlign.center,
                        style: AppText.koulen(
                          30,
                          color: AppColors.pinkBtn.withOpacity(0.75),
                          letterSpacing: 1,
                        )),
                    const SizedBox(height: 30),

                    _SituationRow(
                      image: 'assets/images/ily_flower.png',
                      note: 'Bouquets are arranged\nin size M (31 flowers).',
                      label: 'to say "i love you"',
                      flowerOnLeft: true,
                      arrowOnTop: true,
                      onTap: () => _openResult(context,
                          title: 'to say "I love you"', size: 31),
                    ),
                    const SizedBox(height: 8),

                    _SituationRow(
                      image: 'assets/images/apologize_flower.png',
                      note: 'Bouquets are arranged\nin size L (51 flowers).',
                      label: 'to apologize',
                      flowerOnLeft: false,
                      arrowOnTop: false,
                      onTap: () => _openResult(context,
                          title: 'to apologize', size: 51),
                    ),
                    const SizedBox(height: 8),

                    _SituationRow(
                      image: 'assets/images/foradate_flower.png',
                      note: 'Bouquets are arranged\nin size S (21 flowers).',
                      label: 'for the first date',
                      flowerOnLeft: true,
                      arrowOnTop: false,
                      onTap: () => _openResult(context,
                          title: 'for the first date', size: 21),
                    ),
                    const SizedBox(height: 8),

                    _SituationRow(
                      image: 'assets/images/another_flower.png',
                      note:
                          'Bouquets are made\nbased on the number\nof selected flowers.',
                      label: 'another',
                      flowerOnLeft: false,
                      arrowOnTop: false,
                      onTap: () => Navigator.of(context)
                          .pushNamed('/choose-favorites'),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 6, top: 16, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('OR ',
                                style: AppText.laila(12,
                                    color: AppColors.wine,
                                    weight: FontWeight.w700)),
                            Text('CREATE',
                                style: AppText.koulen(30,
                                    color: AppColors.wine
                                        .withOpacity(0.9))),
                            Text('it yourself',
                                style: AppText.laila(14,
                                    color: AppColors.pinkBtn)),
                          ],
                        ),
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
        onTap: (i) {
          if (i == 0) Navigator.of(context).pushReplacementNamed('/');
          if (i == 1) Navigator.of(context).pushNamed('/create');
          if (i == 2) Navigator.of(context).pushNamed('/profile');
        },
      ),
    );
  }

  void _openResult(BuildContext context,
      {required String title, required int size}) {
    Navigator.of(context).pushNamed(
      '/result',
      arguments: {
        'title': title,
        'size': size,
        'liked': <String>[],
      },
    );
  }
}


class _SituationRow extends StatelessWidget {
  final String image;
  final String note;
  final String label;
  final bool flowerOnLeft;
  final bool arrowOnTop;   
  final VoidCallback onTap;

  const _SituationRow({
    required this.image,
    required this.note,
    required this.label,
    required this.flowerOnLeft,
    required this.arrowOnTop,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: SizedBox(
        height: 210,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: flowerOnLeft ? 80 : 0,
              right: flowerOnLeft ? 0 : 80,
              child: Text(
                note,
                textAlign:
                    flowerOnLeft ? TextAlign.left : TextAlign.right,
                style: AppText.laila(10, color: AppColors.pinkBtn),
              ),
            ),

            Positioned(
              top: 30,
              left: flowerOnLeft ? 60 : null,
              right: flowerOnLeft ? null : 60,
              child: CustomPaint(
                size: const Size(50, 60),
                painter: _CurvedArrowPainter(
                  pointLeft: flowerOnLeft,
                ),
              ),
            ),

            Positioned(
              top: 80,
              left: flowerOnLeft ? 0 : null,
              right: flowerOnLeft ? null : 0,
              child: Image.asset(image, width: 130),
            ),

            Positioned(
              bottom: 0,
              left: flowerOnLeft ? 0 : null,
              right: flowerOnLeft ? null : 0,
              width: 160,
              child: Text(
                label,
                textAlign:
                    flowerOnLeft ? TextAlign.left : TextAlign.right,
                style: AppText.laila(15, color: AppColors.wine),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _CurvedArrowPainter extends CustomPainter {
  final bool pointLeft;
  _CurvedArrowPainter({required this.pointLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF8B1F26)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path();
    if (pointLeft) {
      path.moveTo(size.width, 0);
      path.quadraticBezierTo(
        size.width * 0.2,
        size.height * 0.3,
        size.width * 0.35,
        size.height,
      );
    } else {
      path.moveTo(0, 0);
      path.quadraticBezierTo(
        size.width * 0.8,
        size.height * 0.3,
        size.width * 0.65,
        size.height,
      );
    }
    canvas.drawPath(path, paint);

    final tipX = pointLeft ? size.width * 0.35 : size.width * 0.65;
    final tipY = size.height;
    final arrow = Path()
      ..moveTo(tipX - 5, tipY - 6)
      ..lineTo(tipX, tipY)
      ..lineTo(tipX + 5, tipY - 6);
    canvas.drawPath(arrow, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}