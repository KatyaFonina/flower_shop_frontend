import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/cart_data.dart';
import '../data/extras_data.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/tap_scale.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/api_client.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TapScale(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 52,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.softPink,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.arrow_back,
                          size: 16, color: AppColors.wine),
                    ),
                  ),
                  TapScale(
                    onTap: () => Navigator.of(context).pushNamed('/profile'),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.mint,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.person_outline,
                          size: 20, color: AppColors.darkGreen),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ValueListenableBuilder<List<CartItem>>(
                valueListenable: CartData.instance.items,
                builder: (_, list, __) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),

                        if (list.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 60),
                            child: Center(
                              child: Text(
                                'Cart is empty',
                                style: AppText.laila(14, color: AppColors.wine),
                              ),
                            ),
                          ),

                        ...list.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _CartItemWidget(item: item),
                            )),

                        const SizedBox(height: 20),
                        Text('would love to add',
                            style:
                                AppText.laila(16, color: AppColors.darkGreen)),
                        const SizedBox(height: 12),

                        ValueListenableBuilder<List<ExtraItem>>(
                          valueListenable: ExtrasData.instance.items,
                          builder: (_, extras, __) {
                            return Row(
                              children: extras.map((e) {
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: _ExtraCard(
                                      extra: e,
                                      onTap: () =>
                                          ExtrasData.instance.toggle(e.id),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        const SizedBox(height: 24),

                        ValueListenableBuilder<List<CartItem>>(
                          valueListenable: CartData.instance.items,
                          builder: (_, items, __) {
                            return ValueListenableBuilder<List<ExtraItem>>(
                              valueListenable: ExtrasData.instance.items,
                              builder: (_, extras, ___) {
                                final itemsTotal = items.fold(
                                    0, (s, i) => s + i.price * i.qty);
                                final extrasTotal = extras
                                    .where((e) => e.selected)
                                    .fold(0, (s, e) => s + e.price);
                                final total = itemsTotal + extrasTotal;

                                return Center(
                                  child: Text(
                                    'Total: $total ₽',
                                    style: AppText.laila(16,
                                        color: AppColors.wine,
                                        weight: FontWeight.w700),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        Center(
                          child: TapScale(
                            onTap: () async {
                              final items = CartData.instance.items.value;
                              if (items.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Корзина пуста')),
                                );
                                return;
                              }

                              final orderItems = items
                                  .map((i) => {
                                        'name': i.name,
                                        'image': i.image,
                                        'price': i.price,
                                        'qty': i.qty,
                                      })
                                  .toList();

                              for (final extra
                                  in ExtrasData.instance.selected) {
                                orderItems.add({
                                  'name': extra.name,
                                  'image': extra.image,
                                  'price': extra.price,
                                  'qty': 1,
                                });
                              }

                              final total = CartData.instance.items.value
                                      .fold(0, (s, i) => s + i.price * i.qty) +
                                  ExtrasData.instance.selectedTotalPrice;

                              final prefs =
                                  await SharedPreferences.getInstance();
                              final address = prefs.getString('address');

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.pinkBtn),
                                ),
                              );

                              try {
                                await ApiClient.createOrder(
                                  items: orderItems,
                                  total: total,
                                  address: address,
                                );

                                if (!context.mounted) return;
                                Navigator.of(context).pop();

                                CartData.instance.clear();
                                for (final e
                                    in ExtrasData.instance.items.value) {
                                  if (e.selected)
                                    ExtrasData.instance.toggle(e.id);
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Заказ оформлен!'),
                                    backgroundColor: AppColors.pinkBtn,
                                  ),
                                );

                                Navigator.of(context).pushNamed('/orders');
                              } catch (e) {
                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Ошибка заказа: $e'),
                                    backgroundColor: AppColors.wine,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                              decoration: BoxDecoration(
                                color: AppColors.softPink,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Text('buy it now →',
                                  style:
                                      AppText.laila(14, color: AppColors.wine)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 0,
        onTap: (i) {
          if (i == 0) Navigator.of(context).pushReplacementNamed('/');
          if (i == 1) Navigator.of(context).pushNamed('/create');
          if (i == 2) Navigator.of(context).pushNamed('/profile');
        },
      ),
    );
  }
}

class _CartItemWidget extends StatelessWidget {
  final CartItem item;
  const _CartItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.mint, width: 1.5),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.pinkBtn.withOpacity(0.5)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset(item.image, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(item.name,
                style: AppText.koulen(13, color: AppColors.wine)),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TapScale(
                onTap: () => CartData.instance.dec(item.name),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: AppColors.pinkBtn,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.remove,
                      color: AppColors.white, size: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('${item.qty}',
                    style: AppText.koulen(18, color: AppColors.wine)),
              ),
              TapScale(
                onTap: () => CartData.instance.inc(item.name),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: AppColors.pinkBtn,
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.add, color: AppColors.white, size: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExtraCard extends StatelessWidget {
  final ExtraItem extra;
  final VoidCallback onTap;
  const _ExtraCard({required this.extra, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.softPink,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: extra.selected ? AppColors.wine : Colors.transparent,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(6),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(extra.image, fit: BoxFit.contain),
            ),
            const SizedBox(height: 4),
            Text(
              '${extra.price}₽',
              style: AppText.laila(10,
                  color: extra.selected ? AppColors.wine : AppColors.pinkBtn,
                  weight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
