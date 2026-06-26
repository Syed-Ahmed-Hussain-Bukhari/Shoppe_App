import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product_model.dart';
import '../models/cart_item_model.dart';

class DatabaseService {
  static Database? _db;
  static const String _dbName = 'shoppe.db';
  static const int _dbVersion = 1;


  static const String _cartTable = 'cart';
  static const String _favouritesTable = 'favourites';

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
   
    await db.execute('''
      CREATE TABLE $_cartTable (
        id          INTEGER PRIMARY KEY,
        title       TEXT    NOT NULL,
        price       REAL    NOT NULL,
        description TEXT    NOT NULL,
        category    TEXT    NOT NULL,
        image       TEXT    NOT NULL,
        rating_rate REAL    NOT NULL,
        rating_count INTEGER NOT NULL,
        quantity    INTEGER NOT NULL DEFAULT 1
      )
    ''');

    await db.execute('''
      CREATE TABLE $_favouritesTable (
        id          INTEGER PRIMARY KEY,
        title       TEXT    NOT NULL,
        price       REAL    NOT NULL,
        description TEXT    NOT NULL,
        category    TEXT    NOT NULL,
        image       TEXT    NOT NULL,
        rating_rate REAL    NOT NULL,
        rating_count INTEGER NOT NULL
      )
    ''');

    debugPrint('✅ DB tables created');
  }


  static Future<List<CartItemModel>> getCartItems() async {
    final db = await database;
    final rows = await db.query(_cartTable);
    return rows.map(_rowToCartItem).toList();
  }

  static Future<void> insertCartItem(ProductModel product, int quantity) async {
    final db = await database;
    await db.insert(
      _cartTable,
      _productToCartRow(product, quantity),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint('💾 Cart saved: ${product.title} x$quantity');
  }

  static Future<void> updateCartQuantity(int productId, int quantity) async {
    final db = await database;
    await db.update(
      _cartTable,
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  static Future<void> deleteCartItem(int productId) async {
    final db = await database;
    await db.delete(_cartTable, where: 'id = ?', whereArgs: [productId]);
    debugPrint('🗑️ Cart item deleted: id=$productId');
  }

  static Future<void> clearCart() async {
    final db = await database;
    await db.delete(_cartTable);
    debugPrint('🗑️ Cart cleared');
  }


  static Future<List<ProductModel>> getFavourites() async {
    final db = await database;
    final rows = await db.query(_favouritesTable);
    return rows.map(_rowToProduct).toList();
  }

  static Future<void> insertFavourite(ProductModel product) async {
    final db = await database;
    await db.insert(
      _favouritesTable,
      _productToFavRow(product),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint('💾 Favourite saved: ${product.title}');
  }

  static Future<void> deleteFavourite(int productId) async {
    final db = await database;
    await db.delete(_favouritesTable, where: 'id = ?', whereArgs: [productId]);
    debugPrint('🗑️ Favourite deleted: id=$productId');
  }

  static Future<void> clearFavourites() async {
    final db = await database;
    await db.delete(_favouritesTable);
  }

  static Map<String, dynamic> _productToCartRow(
      ProductModel p, int quantity) => {
        'id': p.id,
        'title': p.title,
        'price': p.price,
        'description': p.description,
        'category': p.category,
        'image': p.image,
        'rating_rate': p.rating.rate,
        'rating_count': p.rating.count,
        'quantity': quantity,
      };

  static Map<String, dynamic> _productToFavRow(ProductModel p) => {
        'id': p.id,
        'title': p.title,
        'price': p.price,
        'description': p.description,
        'category': p.category,
        'image': p.image,
        'rating_rate': p.rating.rate,
        'rating_count': p.rating.count,
      };

  static CartItemModel _rowToCartItem(Map<String, dynamic> row) {
    return CartItemModel(
      product: _rowToProduct(row),
      quantity: row['quantity'] as int,
    );
  }

  static ProductModel _rowToProduct(Map<String, dynamic> row) {
    return ProductModel(
      id: row['id'] as int,
      title: row['title'] as String,
      price: row['price'] as double,
      description: row['description'] as String,
      category: row['category'] as String,
      image: row['image'] as String,
      rating: ProductRating(
        rate: row['rating_rate'] as double,
        count: row['rating_count'] as int,
      ),
    );
  }
}