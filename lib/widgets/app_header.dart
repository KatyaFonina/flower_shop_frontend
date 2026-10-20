import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../data/cart_data.dart';
import 'tap_scale.dart';

class AppHeader extends StatefulWidget {
  final VoidCallback? onCartTap;
  final VoidCallback? onProfileTap;

  const AppHeader({
    super.key,
    this.onCartTap,
    this.onProfileTap,
  });

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  String _address = 'address';

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  Future<void> _loadAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('address');
    if (saved != null && mounted) {
      setState(() => _address = saved);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cream,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TapScale(
            onTap: widget.onCartTap,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _CircleIcon(
                  bg: AppColors.softPink,
                  child: const Icon(Icons.shopping_bag_outlined,
                      size: 20, color: AppColors.wine),
                ),
                ValueListenableBuilder<int>(
                  valueListenable: CartData.instance.totalQty,
                  builder: (_, count, __) {
                    if (count == 0) return const SizedBox.shrink();
                    return Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        constraints: const BoxConstraints(minWidth: 18),
                        decoration: BoxDecoration(
                          color: AppColors.wine,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: AppColors.cream, width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$count',
                          style: AppText.laila(10,
                              color: AppColors.cream, weight: FontWeight.w700),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          TapScale(
            onTap: () async {
              await Navigator.of(context).pushNamed('/address'); // без <bool>
              _loadAddress(); 
            },
            child: Container(
              constraints: const BoxConstraints(maxWidth: 160),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.softPink,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _address,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppText.laila(12, color: AppColors.darkGreen),
              ),
            ),
          ),

          TapScale(
            onTap: widget.onProfileTap,
            child: _CircleIcon(
              bg: AppColors.mint,
              child: const Icon(Icons.person_outline,
                  size: 20, color: AppColors.darkGreen),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final Color bg;
  final Widget child;
  const _CircleIcon({required this.bg, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: child,
    );
  }
}
