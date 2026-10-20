import 'dart:convert';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/api_client.dart';
import '../widgets/tap_scale.dart';
import '../widgets/top_back_button.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiClient.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            const TopBackButton(),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _future,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.pinkBtn),
                    );
                  }
                  if (snap.hasError) {
                    return Center(
                      child: Text('Ошибка: ${snap.error}',
                          style: AppText.laila(12,
                              color: AppColors.wine)),
                    );
                  }

                  final orders = snap.data ?? [];

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: Text('ORDER HISTORY',
                              style: AppText.koulen(28,
                                  color: AppColors.wine)),
                        ),
                        const SizedBox(height: 30),

                        if (orders.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 60),
                            child: Center(
                              child: Text('Пока заказов нет',
                                  style: AppText.laila(14,
                                      color: AppColors.wine)),
                            ),
                          ),

                        ...orders.map((o) => _OrderItem(order: o)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  final Map<String, dynamic> order;
  const _OrderItem({required this.order});

  @override
  Widget build(BuildContext context) {
    // Дата
    final created = DateTime.tryParse(order['createdAt'] ?? '') ??
        DateTime.now();
    final dateStr =
        '${created.day.toString().padLeft(2, '0')}.${created.month.toString().padLeft(2, '0')}.${created.year}';

    // Товары
    final items = (jsonDecode(order['items'] ?? '[]') as List).cast<Map<String, dynamic>>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(dateStr,
            style: AppText.laila(14,
                color: AppColors.darkGreen,
                weight: FontWeight.w700)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cream,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.mint, width: 1.5),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColors.pinkBtn.withOpacity(0.5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Image.asset(
                              item['image'] ?? '',
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.local_florist,
                                color: AppColors.pinkBtn,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${item['name']} × ${item['qty']}',
                            style: AppText.laila(13,
                                color: AppColors.wine),
                          ),
                        ),
                        Text('${(item['price'] ?? 0) * (item['qty'] ?? 1)}₽',
                            style: AppText.laila(13,
                                color: AppColors.wine,
                                weight: FontWeight.w700)),
                      ],
                    ),
                  )),
              const Divider(color: AppColors.softPink),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      style: AppText.laila(13,
                          color: AppColors.darkGreen)),
                  Text('${order['total']}₽',
                      style: AppText.laila(14,
                          color: AppColors.wine,
                          weight: FontWeight.w700)),
                ],
              ),
              if (order['address'] != null) ...[
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 14, color: AppColors.pinkBtn),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        order['address'],
                        style: AppText.laila(12,
                            color: AppColors.darkGreen),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}