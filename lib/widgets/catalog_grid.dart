import 'package:flutter/material.dart';
import '../data/api_client.dart';
import '../theme/app_theme.dart';
import 'flower_card.dart';

class CatalogGrid extends StatefulWidget {
  const CatalogGrid({super.key, this.category = 'flower'});
  final String category;

  @override
  State<CatalogGrid> createState() => _CatalogGridState();
}

class _CatalogGridState extends State<CatalogGrid> {
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiClient.getFlowers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(color: AppColors.pinkBtn),
            ),
          );
        }
        if (snap.hasError) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text('Ошибка: ${snap.error}',
                style: AppText.laila(12, color: AppColors.wine)),
          );
        }

        final all = snap.data ?? [];
        final filtered =
            all.where((f) => f['category'] == widget.category).toList();

        if (filtered.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text('Нет данных. Добавьте товары через Swagger.',
                style: AppText.laila(12, color: AppColors.wine)),
          );
        }

        return Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.55,
                child: Image.asset(
                  'assets/images/bg_flower.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.79,
                children: filtered.map((f) {
                  return Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.95,
                      child: FlowerCard(
                        image: 'assets/images/${f['image']}',
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/flower',
                            arguments: {
                              'title': f['name'],
                              'description': f['description'],
                              'price': '${f['price']}p./шт',
                              'image': 'assets/images/${f['image']}',
                            },
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
