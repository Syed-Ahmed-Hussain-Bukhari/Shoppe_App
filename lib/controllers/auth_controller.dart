import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shoppe/controllers/cart_controller.dart';
import 'package:shoppe/controllers/favourites_controller.dart';
import 'package:shoppe/services/database_services.dart';
import '../routes/app_routes.dart';
import '../services/shared_prefs_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isPasswordHidden = true.obs;

  static const String _validEmail = 'ahmed24@gmail.com';
  static const String _validPassword = 'pass123';
  static const String userName = 'Ahmed';
  static const String userEmail = _validEmail;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));

    if (email.trim() == _validEmail && password == _validPassword) {
      await SharedPrefsService.setLoggedIn(true);
      await SharedPrefsService.setUserEmail(email.trim());
      debugPrint('✅ Login successful');
      Get.offAllNamed(AppRoutes.mainNav);
    } else {
      _showError('Invalid email or password');
    }
    isLoading.value = false;
  }

  // Future<void> logout() async {
  //   await SharedPrefsService.setLoggedIn(false);
  //   Get.offAllNamed(AppRoutes.login);
  // }

// Future<void> logout() async {
//   // Clear local storage
//   await DatabaseService.clearCart();
//   await DatabaseService.clearFavourites();

//   // Clear in-memory state
//   Get.find<CartController>().cartItems.clear();
//   Get.find<FavouritesController>().favourites.clear();

//   await SharedPrefsService.setLoggedIn(false);

//   Get.snackbar(
//     'Logged Out',
//     'You have been logged out successfully',
//     snackPosition: SnackPosition.BOTTOM,
//     backgroundColor: const Color(0xFF2C2C2C),
//     colorText: Colors.white,
//     margin: const EdgeInsets.all(12),
//     borderRadius: 12,
//     duration: const Duration(seconds: 2),
//   );

//   Get.offAllNamed(AppRoutes.login);
// }

Future<void> logout() async {

  await DatabaseService.clearCart();
  await DatabaseService.clearFavourites();

  await FlutterLocalNotificationsPlugin().cancelAll();

  Get.find<CartController>().cartItems.clear();
  Get.find<FavouritesController>().favourites.clear();

  await SharedPrefsService.setLoggedIn(false);

  Get.snackbar(
    'Logged Out',
    'You have been logged out successfully',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: const Color(0xFF2C2C2C),
    colorText: Colors.white,
    margin: const EdgeInsets.all(12),
    borderRadius: 12,
    duration: const Duration(seconds: 2),
  );

  Get.offAllNamed(AppRoutes.login);
}


  void _showError(String message) {
    Get.snackbar(
      'Login Failed',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE74C3C),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error_outline, color: Colors.white),
    );
  }
}