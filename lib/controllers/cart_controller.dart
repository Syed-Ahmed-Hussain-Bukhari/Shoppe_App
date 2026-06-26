import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe/services/database_services.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import '../services/notification_service.dart';

class CartController extends GetxController {
  var cartItems = <CartItemModel>[].obs;
  var isLoading = false.obs;

  int get totalItemCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool isInCart(int productId) =>
      cartItems.any((item) => item.product.id == productId);

  int getQuantity(int productId) {
    final item = cartItems.firstWhereOrNull(
      (i) => i.product.id == productId,
    );
    return item?.quantity ?? 0;
  }

 
  @override
  void onInit() {
    super.onInit();
    _loadCartFromDb();
  }

  Future<void> _loadCartFromDb() async {
    try {
      isLoading.value = true;
      final saved = await DatabaseService.getCartItems();
      cartItems.value = saved;
      debugPrint('🛒 Cart loaded from DB: ${saved.length} items');
    } catch (e) {
      debugPrint('❌ Error loading cart from DB: $e');
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> addToCart(ProductModel product) async {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex != -1) {
    
      cartItems[existingIndex].quantity++;
      cartItems.refresh();
      
      await DatabaseService.updateCartQuantity(
        product.id,
        cartItems[existingIndex].quantity,
      );
    } else {
      
      final newItem = CartItemModel(product: product);
      cartItems.add(newItem);
      await DatabaseService.insertCartItem(product, 1);
    }

    debugPrint('🛒 Added to cart: ${product.title}');
    await NotificationService.showAddToCartNotification(
      productId: product.id,
      productTitle: product.title,
    );
  }

  Future<void> removeFromCart(int productId) async {
    cartItems.removeWhere((item) => item.product.id == productId);
    await DatabaseService.deleteCartItem(productId);
    _showRemovedSnackbar();
  }

  Future<void> increaseQuantity(int productId) async {
    final index = cartItems.indexWhere(
      (item) => item.product.id == productId,
    );
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
      await DatabaseService.updateCartQuantity(
        productId,
        cartItems[index].quantity,
      );
    }
  }

  Future<void> decreaseQuantity(int productId) async {
    final index = cartItems.indexWhere(
      (item) => item.product.id == productId,
    );
    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        cartItems.refresh();
        await DatabaseService.updateCartQuantity(
          productId,
          cartItems[index].quantity,
        );
      } else {
        
        await removeFromCart(productId);
      }
    }
  }

  Future<void> clearCart() async {
    cartItems.clear();
    await DatabaseService.clearCart();
  }


  void _showRemovedSnackbar() {
    Get.snackbar(
      'Removed',
      'Item removed from cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE74C3C),
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}