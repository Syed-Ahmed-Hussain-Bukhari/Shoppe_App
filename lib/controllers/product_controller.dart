import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

enum ProductLoadState { initial, loading, success, error }

class ProductController extends GetxController {
  final ProductService _productService = ProductService();

  var loadState = ProductLoadState.initial.obs;
  var products = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;
  var selectedProduct = Rx<ProductModel?>(null);
  var errorMessage = ''.obs;
  var selectedCategory = 'all'.obs;
  var categories = <String>['all'].obs;
  var isDetailLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      loadState.value = ProductLoadState.loading;
      errorMessage.value = '';

      final fetchedProducts = await _productService.fetchProducts();
      products.value = fetchedProducts;

      final cats = fetchedProducts.map((p) => p.category).toSet().toList();
      categories.value = ['all', ...cats];

     final active = selectedCategory.value;
      if (active == 'all' || !cats.contains(active)) {
        filteredProducts.value = fetchedProducts;
        selectedCategory.value = 'all';
      } else {
        filteredProducts.value =
            fetchedProducts.where((p) => p.category == active).toList();
      }

      loadState.value = ProductLoadState.success;
      debugPrint('✅ Products loaded: ${fetchedProducts.length}, active: $active');
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      loadState.value = ProductLoadState.error;
      debugPrint('❌ Error loading products: $e');
    }
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (category == 'all') {
      filteredProducts.value = products;
    } else {
      filteredProducts.value =
          products.where((p) => p.category == category).toList();
    }
  }

  Future<void> fetchProductById(int id) async {
    try {
      isDetailLoading.value = true;

      final existing = products.firstWhereOrNull((p) => p.id == id);
      if (existing != null) {
        selectedProduct.value = existing;
        isDetailLoading.value = false;
        return;
      }

      
      final product = await _productService.fetchProductById(id);
      selectedProduct.value = product;
    } catch (e) {
      debugPrint('❌ Error fetching product: $e');
      Get.snackbar(
        'Error',
        'Failed to load product details',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isDetailLoading.value = false;
    }
  }

  void setSelectedProduct(ProductModel product) {
    selectedProduct.value = product;
  }
}