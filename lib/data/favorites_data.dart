import 'package:flutter/material.dart';

class FavItem {
  final String name;
  final String image;
  final int price;
  final String description;

  const FavItem({
    required this.name,
    required this.image,
    required this.price,
    this.description = '',
  });
}

class FavoritesData {
  FavoritesData._();
  static final FavoritesData instance = FavoritesData._();

  final ValueNotifier<List<FavItem>> items =
      ValueNotifier<List<FavItem>>([]);

  bool contains(String name) =>
      items.value.any((i) => i.name == name);

  void toggle(FavItem item) {
    final list = List<FavItem>.from(items.value);
    final idx = list.indexWhere((i) => i.name == item.name);
    if (idx >= 0) {
      list.removeAt(idx);
    } else {
      list.add(item);
    }
    items.value = list;
  }
}