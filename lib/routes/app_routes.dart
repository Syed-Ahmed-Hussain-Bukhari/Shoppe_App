import 'package:get/get.dart';
import 'package:shoppe/view/favourites/favourites_screen.dart';
import 'package:shoppe/view/home/main_nav_screen.dart';
import 'package:shoppe/view/profile/profile_screen.dart';
import '../view/splash/splash_screen.dart';
import '../view/auth/login_screen.dart';
import '../view/products/product_list_screen.dart';
import '../view/products/product_detail_screen.dart';
import '../view/cart/cart_screen.dart';
import '../view/settings/settings_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String mainNav = '/main';
  static const String productList = '/products';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String settings = '/settings';
  static const String favourites = '/favourites';
  static const String profile = '/profile';

  static final List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: mainNav, page: () => const MainNavScreen()),
    GetPage(name: productList, page: () => const ProductListScreen()),
    GetPage(
      name: productDetail,
      page: () => const ProductDetailScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(name: cart, page: () => const CartScreen()),
    GetPage(name: settings, page: () => const SettingsScreen()),
    GetPage(name: favourites, page: () => const FavouritesScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
  ];
}