import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const cream     = Color(0xFFFFFDF8);
  static const softPink  = Color(0xFFFEE9E7);
  static const mint      = Color(0xFFCEFFBE);
  static const pinkLight = Color(0xFFF9ACAC);
  static const pink      = Color(0xFFFAA8B3);
  static const pinkBtn   = Color(0xFFFBA6B3);
  static const pinkGrad  = Color(0xFFFBB3BF);
  static const wine      = Color(0xFFAE2831);
  static const darkGreen = Color(0xFF3F4626);
  static const white     = Color(0xFFFFFFFF);
}

class AppText {
  static TextStyle koulen(
    double size, {
    Color color = AppColors.pinkLight,
    double letterSpacing = 1.2,
  }) =>
      GoogleFonts.koulen(
        fontSize: size,
        color: color,
        letterSpacing: letterSpacing,
      );

  static TextStyle laila(
    double size, {
    Color color = AppColors.darkGreen,
    FontWeight weight = FontWeight.w400,
    double? height,
  }) =>
      GoogleFonts.laila(
        fontSize: size,
        color: color,
        fontWeight: weight,
        height: height,
      );
}