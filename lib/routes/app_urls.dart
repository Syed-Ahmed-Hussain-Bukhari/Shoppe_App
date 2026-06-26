class APIEndPoints {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String products = '$baseUrl/products';
  static String productById(int id) => '$products/$id';
  static const String categories = '$products/categories';
}