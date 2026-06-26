import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../routes/app_urls.dart';

class ProductService {
  final Dio _dio = Dio();

  Future<List<ProductModel>> fetchProducts() async {
    try {
      debugPrint('🛍️ Fetching products from API');
      final response = await _dio.get(APIEndPoints.products);
      debugPrint('✅ Products fetched: ${(response.data as List).length}');
      return (response.data as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } on DioException catch (e) {
      debugPrint('❌ DioError fetching products: ${e.message}');
      throw Exception(e.response?.data?['message'] ?? 'Failed to load products');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<ProductModel> fetchProductById(int id) async {
    try {
      debugPrint('🛍️ Fetching product #$id');
      final response = await _dio.get(APIEndPoints.productById(id));
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ DioError fetching product: ${e.message}');
      throw Exception('Failed to load product details');
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }
}