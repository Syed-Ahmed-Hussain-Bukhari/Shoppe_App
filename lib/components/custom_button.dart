import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool loading;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? radius;
  final Widget? icon;
  final bool outlined;

  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.loading = false,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.radius,
    this.icon,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final btnColor = color ?? AppColors.primaryColor;

    return GestureDetector(
      onTap: loading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: width ?? double.infinity,
        height: height ?? h * 0.065,
        decoration: BoxDecoration(
          color: outlined ? Colors.transparent : (loading ? btnColor.withOpacity(0.7) : btnColor),
          border: outlined ? Border.all(color: btnColor, width: 2) : null,
          borderRadius: BorderRadius.circular(radius ?? h * 0.04),
          boxShadow: outlined
              ? null
              : [
                  BoxShadow(
                    color: btnColor.withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Center(
          child: loading
              ? SizedBox(
                  height: h * 0.028,
                  width: h * 0.028,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      outlined ? btnColor : Colors.white,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      SizedBox(width: w * 0.02),
                    ],
                    Text(
                      title,
                      style: GoogleFonts.raleway(
                        fontSize: w * 0.042,
                        fontWeight: FontWeight.w700,
                        color: outlined ? btnColor : (textColor ?? Colors.white),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}