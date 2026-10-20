import 'package:flutter/material.dart';

class ExtraItem {
  final String id;
  final String name;
  final String image;
  final int price;
  bool selected;

  ExtraItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.selected = false,
  });
}

class ExtrasData {
  ExtrasData._();
  static final ExtrasData instance = ExtrasData._();

  final ValueNotifier<List<ExtraItem>> items = ValueNotifier<List<ExtraItem>>([
    ExtraItem(
      id: 'envelope',
      name: 'Envelope',
      image: 'assets/images/envelope.png',
      price: 100,
    ),
    ExtraItem(
      id: 'tape',
      name: 'Tape',
      image: 'assets/images/tape.png',
      price: 150,
    ),
    ExtraItem(
      id: 'wrap',
      name: 'Wrapping paper',
      image: 'assets/images/wrap.png',
      price: 200,
    ),
    ExtraItem(
      id: 'package',
      name: 'Package',
      image: 'assets/images/package.png',
      price: 250,
    ),
  ]);

  void toggle(String id) {
    final list = List<ExtraItem>.from(items.value);
    final idx = list.indexWhere((i) => i.id == id);
    if (idx >= 0) {
      list[idx].selected = !list[idx].selected;
      items.value = list;
    }
  }

  int get selectedTotalPrice => items.value
      .where((i) => i.selected)
      .fold(0, (s, i) => s + i.price);

  List<ExtraItem> get selected => items.value.where((i) => i.selected).toList();
}