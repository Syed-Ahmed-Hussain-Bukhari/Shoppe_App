
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe/routes/app_routes.dart';
import 'package:shoppe/services/shared_prefs_service.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController logoController;
  late AnimationController textController;
  late Animation<double> logoScale;
  late Animation<double> textOpacity;
  late Animation<Offset> textSlide;

  @override
  void onInit() {
    super.onInit();
    _setupAnimations();
    _startSequence();
  }

  void _setupAnimations() {
    logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    logoScale = CurvedAnimation(
      parent: logoController,
      curve: Curves.elasticOut,
    );

    textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: textController, curve: Curves.easeIn),
    );

    textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: textController, curve: Curves.easeOut),
    );
  }

  Future<void> _startSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));
    logoController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    textController.forward();
    await Future.delayed(const Duration(milliseconds: 1200));
    _navigate();
  }

  Future<void> _navigate() async {
    final loggedIn = await SharedPrefsService.isLoggedIn();
    if (loggedIn) {
      Get.offAllNamed(AppRoutes.mainNav);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void onClose() {
    logoController.dispose();
    textController.dispose();
    super.onClose();
  }
}