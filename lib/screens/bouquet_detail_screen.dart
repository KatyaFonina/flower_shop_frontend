import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/cart_data.dart';
import '../data/favorites_data.dart';
import '../widgets/app_header.dart';
import '../widgets/tap_scale.dart';

class BouquetDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String price;
  final String image;

  const BouquetDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  @override
  State<BouquetDetailScreen> createState() => _BouquetDetailScreenState();
}

class _BouquetDetailScreenState extends State<BouquetDetailScreen> {
  late bool _liked;

  @override
  void initState() {
    super.initState();
    _liked = FavoritesData.instance.contains(widget.title);
  }

  int _parsePrice(String raw) {
    final digits = raw.replaceAll(RegExp(r'[^\d]'), '');
    return int.tryParse(digits) ?? 0;
  }

  void _toggleFavorite() {
    setState(() => _liked = !_liked);
    FavoritesData.instance.toggle(
      FavItem(
        name: widget.title,
        image: widget.image,
        price: _parsePrice(widget.price),
        description: widget.description,
      ),
    );
  }

  void _addToCart() {
    CartData.instance.add(
      CartItem(
        name: widget.title,
        image: widget.image,
        price: _parsePrice(widget.price),
        qty: 1,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.title} added to cart',
          style: AppText.laila(13, color: AppColors.cream),
        ),
        backgroundColor: AppColors.pinkBtn,
        duration: const Duration(milliseconds: 900),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      height: 400,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.softPink.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: AppColors.pinkBtn, width: 1.5),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: TapScale(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: AppColors.pinkBtn,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close,
                                    color: AppColors.white, size: 18),
                              ),
                            ),
                          ),

                          Positioned(
                            top: 0,
                            right: 0,
                            child: TapScale(
                              onTap: _toggleFavorite,
                              child: Icon(
                                _liked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _liked
                                    ? const Color(0xFFAE2831)
                                    : AppColors.pinkBtn,
                                size: 28,
                              ),
                            ),
                          ),

                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20, 40, 20, 20),
                              child: Image.asset(
                                widget.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text('"${widget.title}"',
                        style: AppText.koulen(26,
                            color: AppColors.wine)),
                    const SizedBox(height: 6),

                    Text(widget.price,
                        style: AppText.laila(16,
                            color: AppColors.pinkBtn)),
                    const SizedBox(height: 16),

                    Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: AppText.laila(13,
                          color: AppColors.wine, height: 1.5),
                    ),
                    const SizedBox(height: 30),

                    TapScale(
                      onTap: _addToCart,
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppColors.pinkBtn,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.pinkBtn.withOpacity(0.4),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.add,
                            color: AppColors.white, size: 32),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}