import 'package:flutter/material.dart';

class Responsive {
  static const double baseWidth = 390;
  static const double baseHeight = 844;

  static double scaleW(BuildContext context) =>
      MediaQuery.of(context).size.width / baseWidth;

  static double scaleH(BuildContext context) =>
      MediaQuery.of(context).size.height / baseHeight;

  static double scale(BuildContext context) =>
      (scaleW(context) + scaleH(context)) / 2;

  static double sp(BuildContext context, double size) =>
      size * scale(context);

  static double wp(BuildContext context, double size) =>
      size * scaleW(context);

  static double hp(BuildContext context, double size) =>
      size * scaleH(context);
}