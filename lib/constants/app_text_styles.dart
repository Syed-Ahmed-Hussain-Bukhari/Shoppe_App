import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle heading1(BuildContext context) => GoogleFonts.raleway(
        fontSize: MediaQuery.of(context).size.width * 0.07,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimaryColor,
      );

  static TextStyle heading2(BuildContext context) => GoogleFonts.raleway(
        fontSize: MediaQuery.of(context).size.width * 0.055,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryColor,
      );

  static TextStyle heading3(BuildContext context) => GoogleFonts.raleway(
        fontSize: MediaQuery.of(context).size.width * 0.045,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryColor,
      );

  static TextStyle body(BuildContext context) => GoogleFonts.raleway(
        fontSize: MediaQuery.of(context).size.width * 0.038,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryColor,
      );

  static TextStyle bodySmall(BuildContext context) => GoogleFonts.raleway(
        fontSize: MediaQuery.of(context).size.width * 0.033,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryColor,
      );

  static TextStyle caption(BuildContext context) => GoogleFonts.raleway(
        fontSize: MediaQuery.of(context).size.width * 0.03,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryColor,
      );

  static TextStyle buttonText(BuildContext context) => GoogleFonts.raleway(
        fontSize: MediaQuery.of(context).size.width * 0.042,
        fontWeight: FontWeight.w700,
        color: AppColors.whiteColor,
      );

  static TextStyle price(BuildContext context) => GoogleFonts.raleway(
        fontSize: MediaQuery.of(context).size.width * 0.045,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimaryColor,
      );
}