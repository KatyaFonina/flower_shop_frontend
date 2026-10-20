import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final String image;
  final int price;
  int qty;

  CartItem({
    required this.name,
    required this.image,
    required this.price,
    this.qty = 1,
  });
}

class CartData {
  CartData._();
  static final CartData instance = CartData._();

  final ValueNotifier<List<CartItem>> items =
      ValueNotifier<List<CartItem>>([]);

  final ValueNotifier<int> totalQty = ValueNotifier<int>(0);

  void _recalc() {
    totalQty.value = items.value.fold(0, (s, i) => s + i.qty);
  }

  void add(CartItem item) {
    final list = List<CartItem>.from(items.value);
    final idx = list.indexWhere((i) => i.name == item.name);
    if (idx >= 0) {
      list[idx].qty += item.qty;
    } else {
      list.add(item);
    }
    items.value = list;
    _recalc();
  }

  void inc(String name) {
    final list = List<CartItem>.from(items.value);
    final idx = list.indexWhere((i) => i.name == name);
    if (idx >= 0) {
      list[idx].qty++;
      items.value = list;
      _recalc();
    }
  }

  void dec(String name) {
    final list = List<CartItem>.from(items.value);
    final idx = list.indexWhere((i) => i.name == name);
    if (idx >= 0) {
      if (list[idx].qty > 1) {
        list[idx].qty--;
      } else {
        list.removeAt(idx);
      }
      items.value = list;
      _recalc();
    }
  }

  void remove(String name) {
    items.value = items.value.where((i) => i.name != name).toList();
    _recalc();
  }

  void clear() {
    items.value = [];
    totalQty.value = 0;
  }

  int get totalPrice =>
      items.value.fold(0, (s, i) => s + i.price * i.qty);
}