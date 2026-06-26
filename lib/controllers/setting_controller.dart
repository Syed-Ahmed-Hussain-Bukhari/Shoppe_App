
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shoppe/services/shared_prefs_service.dart';

class SettingsController extends GetxController {
  final fcmToken = RxnString(); // null = loading

  @override
  void onInit() {
    super.onInit();
    loadToken();
  }

  Future<void> loadToken() async {
    fcmToken.value = null; 
  
    String? token = await SharedPrefsService.getFcmToken();

  
    if (token == null || token.trim().isEmpty) {
      token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await SharedPrefsService.saveFcmToken(token);
      }
    }

    fcmToken.value = token ?? 'Token unavailable';
  }
}