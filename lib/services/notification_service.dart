import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/shared_prefs_service.dart';


@pragma('vm:entry-point')
Future<void> firebaseBackgroundMessageHandler(RemoteMessage message) async {
  debugPrint('📱 Background FCM message: ${message.messageId}');
 
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'shoppe_high_importance_channel',
    'Shoppe Notifications',
    description: 'Shoppe product and order notifications',
    importance: Importance.max,
    playSound: true,
  );

    static Future<void> initialize() async {
    await _requestPermission();
    await _initLocalNotifications();
    await _createAndroidChannel();
    await _setupFcmToken();
    _setupForegroundListener();
    _setupOnMessageOpenedApp();
    await _checkInitialMessage();
    _listenTokenRefresh();
  }

 
  static Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('🔔 Notification permission: ${settings.authorizationStatus}');
  }

 
  static Future<void> _initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onNotificationTap,
    );
  }

  static Future<void> _createAndroidChannel() async {
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }


  static Future<void> _setupFcmToken() async {
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        debugPrint('📱 FCM Token: $token');
        await SharedPrefsService.setFcmToken(token);
      }
    } catch (e) {
      debugPrint('❌ Error getting FCM token: $e');
    }
  }

  static Future<String?> getFcmToken() async {
    return SharedPrefsService.getFcmToken();
  }

  static void _listenTokenRefresh() {
    _messaging.onTokenRefresh.listen((newToken) async {
      debugPrint('🔄 FCM Token refreshed: $newToken');
      await SharedPrefsService.setFcmToken(newToken);
    });
  }


  static void _setupForegroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📩 Foreground FCM message: ${message.messageId}');
      final notification = message.notification;
      if (notification != null) {
        _showLocalNotification(
          title: notification.title ?? 'Shoppe',
          body: notification.body ?? '',
          payload: jsonEncode(message.data),
        );
      }
    });
  }


  static void _setupOnMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('📬 Notification tapped (background): ${message.data}');
      _handleNotificationNavigation(message.data);
    });
  }


  static Future<void> _checkInitialMessage() async {
    final message = await _messaging.getInitialMessage();
    if (message != null) {
      debugPrint('🚀 App launched from notification: ${message.data}');
       Future.delayed(const Duration(seconds: 2), () {
        _handleNotificationNavigation(message.data);
      });
    }
  }


  @pragma('vm:entry-point')
  static void _onNotificationTap(NotificationResponse response) {
    debugPrint('🔔 Local notification tapped: ${response.payload}');
    if (response.payload != null) {
      try {
        final data = jsonDecode(response.payload!);
        _handleNotificationNavigation(data);
      } catch (e) {
        debugPrint('❌ Error parsing notification payload: $e');
      }
    }
  }

    static void _handleNotificationNavigation(Map<String, dynamic> data) {
    final type = data['type'];
    final productId = data['product_id'];

    debugPrint('🧭 Navigating from notification — type: $type, id: $productId');

    if (type == 'product' && productId != null) {
      final id = int.tryParse(productId.toString());
      if (id != null) {
        Get.toNamed(AppRoutes.productDetail, arguments: {'productId': id});
      }
    }
  }


  static Future<void> _showLocalNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      ticker: 'Shoppe',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  static Future<void> showAddToCartNotification({
    required int productId,
    required String productTitle,
  }) async {
    final payload = jsonEncode({
      'type': 'product',
      'product_id': productId.toString(),
    });

    await _showLocalNotification(
      title: '🛒 Added to Cart!',
      body: '$productTitle has been added to your cart.',
      payload: payload,
    );
  }

  static Future<void> showAddToFavouriteNotification({
  required int productId,
  required String productTitle,
}) async {
  final payload = jsonEncode({
    'type': 'product',
    'product_id': productId.toString(),
  });

  await _showLocalNotification(
    title: '❤️ Added to Favorites!',
    body: '$productTitle has been added to your favorites.',
    payload: payload,
  );
}
}

