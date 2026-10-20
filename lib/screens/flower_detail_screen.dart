import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/cart_data.dart';
import '../data/favorites_data.dart';
import '../widgets/app_header.dart';
import '../widgets/tap_scale.dart';

class FlowerDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String price;
  final String image;

  const FlowerDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  @override
  State<FlowerDetailScreen> createState() => _FlowerDetailScreenState();
}

class _FlowerDetailScreenState extends State<FlowerDetailScreen> {
  late bool _liked;

  @override
  void initState() {
    super.initState();
    _liked = FavoritesData.instance.contains(widget.title);
  }

  int _parsePrice(String raw) {
    final digits = raw.replaceAll(RegExp(r'[^\d]'), '');
    return int.tryParse(digits) ?? 250;
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
                        border:
                            Border.all(color: AppColors.pinkBtn, width: 1.5),
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

                          Positioned(
                            right: -20,
                            bottom: -20,
                            top: 30,
                            child: Image.asset(
                              widget.image,
                              fit: BoxFit.contain,
                            ),
                          ),

                          Positioned(
                            left: 0,
                            bottom: 20,
                            width: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: AppText.koulen(22,
                                      color: AppColors.wine),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.description,
                                  style: AppText.laila(12,
                                      color: AppColors.wine,
                                      height: 1.5),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.price,
                                  style: AppText.laila(13,
                                      color: AppColors.pinkBtn),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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