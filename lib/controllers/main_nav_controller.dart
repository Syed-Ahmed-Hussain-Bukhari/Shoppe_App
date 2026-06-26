import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoppe/controllers/auth_controller.dart';
import 'package:shoppe/controllers/cart_controller.dart';
import 'package:shoppe/controllers/favourites_controller.dart';
import 'package:shoppe/controllers/nav_controller.dart';

class MainNavController extends GetxController {

  late final NavController nav;
  late final AuthController auth;
  late final CartController cart;
  late final FavouritesController favourites;

  @override
  void onInit() {
    super.onInit();
    nav        = Get.put(NavController());
    auth       = Get.put(AuthController());
    cart       = Get.put(CartController());
    favourites = Get.put(FavouritesController());
  }
}