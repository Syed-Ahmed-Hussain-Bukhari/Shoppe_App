// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../models/product_model.dart';
// // import '../services/hive_service.dart';

// // class FavouritesController extends GetxController {
// //   var favourites = <ProductModel>[].obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     _loadFromHive();
// //   }

// //   void _loadFromHive() {
// //     final box = HiveService.favouritesBox;
// //     favourites.value = box.values.toList();
// //     debugPrint('❤️ Loaded ${favourites.length} favourites from Hive');
// //   }

// //   bool isFavourite(int productId) =>
// //       favourites.any((p) => p.id == productId);

// //   Future<void> toggleFavourite(ProductModel product) async {
// //     final box = HiveService.favouritesBox;
// //     final index = favourites.indexWhere((p) => p.id == product.id);

// //     if (index != -1) {
// //       // Remove from favourites
// //       await box.deleteAt(index);
// //       favourites.removeAt(index);
// //       Get.snackbar(
// //         'Removed from Favourites',
// //         product.title.length > 35
// //             ? '${product.title.substring(0, 35)}...'
// //             : product.title,
// //         snackPosition: SnackPosition.BOTTOM,
// //         backgroundColor: const Color(0xFF7C7F90),
// //         colorText: Colors.white,
// //         margin: const EdgeInsets.all(12),
// //         borderRadius: 12,
// //         duration: const Duration(seconds: 2),
// //         icon: const Icon(Icons.favorite_border, color: Colors.white),
// //       );
// //     } else {
// //       // Add to favourites
// //       await box.add(product);
// //       favourites.add(product);
// //       Get.snackbar(
// //         '❤️ Added to Favourites',
// //         product.title.length > 35
// //             ? '${product.title.substring(0, 35)}...'
// //             : product.title,
// //         snackPosition: SnackPosition.BOTTOM,
// //         backgroundColor: const Color(0xFFE74C3C),
// //         colorText: Colors.white,
// //         margin: const EdgeInsets.all(12),
// //         borderRadius: 12,
// //         duration: const Duration(seconds: 2),
// //         icon: const Icon(Icons.favorite, color: Colors.white),
// //       );
// //     }
// //     debugPrint('❤️ Toggled favourite: ${product.title}');
// //   }

// //   Future<void> removeFavourite(int productId) async {
// //     final box = HiveService.favouritesBox;
// //     final index = favourites.indexWhere((p) => p.id == productId);
// //     if (index != -1) {
// //       await box.deleteAt(index);
// //       favourites.removeAt(index);
// //     }
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../models/product_model.dart';
// import '../services/hive_service.dart';

// class FavouritesController extends GetxController {
//   var favourites = <ProductModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _loadFromHive();
//   }

//   void _loadFromHive() {
//     favourites.value = HiveService.favouritesBox.values.toList();
//     debugPrint('❤️ Loaded ${favourites.length} favourites from Hive');
//   }

//   bool isFavourite(int productId) => favourites.any((p) => p.id == productId);

//   Future<void> toggleFavourite(ProductModel product) async {
//     final box = HiveService.favouritesBox;
//     final index = favourites.indexWhere((p) => p.id == product.id);
//     if (index != -1) {
//       await box.deleteAt(index);
//       favourites.removeAt(index);
//     } else {
//       await box.add(product);
//       favourites.add(product);
//     }
//     debugPrint('❤️ Toggled favourite: ${product.title}');
//   }

//   Future<void> removeFavourite(int productId) async {
//     final index = favourites.indexWhere((p) => p.id == productId);
//     if (index != -1) {
//       await HiveService.favouritesBox.deleteAt(index);
//       favourites.removeAt(index);
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shoppe/services/notification_service.dart';
// import '../models/product_model.dart';

// class FavouritesController extends GetxController {
//   var favourites = <ProductModel>[].obs;

//   bool isFavourite(int productId) =>
//       favourites.any((p) => p.id == productId);

//   Future<void> toggleFavourite(ProductModel product) async {
//     final index = favourites.indexWhere((p) => p.id == product.id);
//     if (index != -1) {
//       favourites.removeAt(index);
//       debugPrint('💔 Removed favourite: ${product.title}');
//       _showRemovedSnackbar();
//     } else {
//       favourites.add(product);
//       debugPrint('❤️ Added favourite: ${product.title}');
//        await NotificationService.showAddToFavouriteNotification(
//       productId: product.id,
//       productTitle: product.title,
//     );
//     }
//   }

//   void removeFavourite(int productId) {
//     favourites.removeWhere((p) => p.id == productId);
//   }

//   void _showRemovedSnackbar() {
//     Get.snackbar(
//        'Removed from Favorites',
//        'Item removed from your favorites list',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: const Color(0xFFE74C3C),
//       colorText: Colors.white,
//       margin: const EdgeInsets.all(12),
//       borderRadius: 12,
//       duration: const Duration(seconds: 2),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe/services/database_services.dart';
import '../models/product_model.dart';
import '../services/notification_service.dart';

class FavouritesController extends GetxController {
  var favourites = <ProductModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadFavouritesFromDb();
  }

  Future<void> _loadFavouritesFromDb() async {
    try {
      isLoading.value = true;
      final saved = await DatabaseService.getFavourites();
      favourites.value = saved;
      debugPrint('❤️ Favourites loaded from DB: ${saved.length} items');
    } catch (e) {
      debugPrint('❌ Error loading favourites from DB: $e');
    } finally {
      isLoading.value = false;
    }
  }

  bool isFavourite(int productId) =>
      favourites.any((p) => p.id == productId);

  Future<void> toggleFavourite(ProductModel product) async {
    final index = favourites.indexWhere((p) => p.id == product.id);

    if (index != -1) {
   
      favourites.removeAt(index);
      await DatabaseService.deleteFavourite(product.id);
      debugPrint('💔 Removed favourite: ${product.title}');
      _showRemovedSnackbar();
    } else {
   
      favourites.add(product);
      await DatabaseService.insertFavourite(product);
      debugPrint('❤️ Added favourite: ${product.title}');
      await NotificationService.showAddToFavouriteNotification(
        productId: product.id,
        productTitle: product.title,
      );
    }
  }

  Future<void> removeFavourite(int productId) async {
    favourites.removeWhere((p) => p.id == productId);
    await DatabaseService.deleteFavourite(productId);
  }


  void _showRemovedSnackbar() {
    Get.snackbar(
      'Removed from Favorites',
      'Item removed from your favorites list',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE74C3C),
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}