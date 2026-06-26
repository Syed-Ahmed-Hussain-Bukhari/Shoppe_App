// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../constants/app_colors.dart';
// import '../../controllers/auth_controller.dart';
// import '../../services/notification_service.dart';
// import '../../services/shared_prefs_service.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   String? _fcmToken;

//   @override
//   void initState() {
//     super.initState();
//     _loadFcmToken();
//   }

//   Future<void> _loadFcmToken() async {
//     final token = await SharedPrefsService.getFcmToken();
//     setState(() => _fcmToken = token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authController = Get.isRegistered<AuthController>()
//         ? Get.find<AuthController>()
//         : Get.put(AuthController());

//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: AppColors.scaffoldBg,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: w * 0.05),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: h * 0.025),
//               Text(
//                 'Settings',
//                 style: GoogleFonts.raleway(
//                   fontSize: w * 0.07,
//                   fontWeight: FontWeight.w900,
//                   color: AppColors.textPrimaryColor,
//                   letterSpacing: -0.5,
//                 ),
//               ),

//               SizedBox(height: h * 0.03),

//                      _SettingsItem(
//                 icon: Icons.info_rounded,
//                 iconColor: AppColors.primaryColor,
//                 title: 'About Shoppe',
//                 subtitle: 'Discover products you love',
//                 onTap: () {
//                   Get.dialog(AlertDialog(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     title: Text('About Shoppe',
//                         style:
//                             GoogleFonts.raleway(fontWeight: FontWeight.w700)),
//                     content: Text(
//                         'Shoppe is a beautiful eCommerce app built with Flutter & GetX.',
//                         style: GoogleFonts.raleway()),
//                     actions: [
//                       TextButton(
//                           onPressed: () => Get.back(),
//                           child: Text('OK',
//                               style: GoogleFonts.raleway(
//                                   color: AppColors.primaryColor,
//                                   fontWeight: FontWeight.w700))),
//                     ],
//                   ));
//                 },
//               ),

//               SizedBox(height: h * 0.03),

//                    Text(
//                 'FIREBASE TESTING',
//                 style: GoogleFonts.raleway(
//                   fontSize: w * 0.033,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.textSecondaryColor,
//                   letterSpacing: 1.2,
//                 ),
//               ),

//               SizedBox(height: h * 0.012),

            
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(w * 0.045),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(w * 0.04),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.04),
//                       blurRadius: 8,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
                   
//                     Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(w * 0.025),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFFF6B00).withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(w * 0.025),
//                           ),
//                           child: Icon(
//                             Icons.notifications_active_rounded,
//                             color: const Color(0xFFFF6B00),
//                             size: w * 0.05,
//                           ),
//                         ),
//                         SizedBox(width: w * 0.03),
//                         Text(
//                           'FCM Device Token',
//                           style: GoogleFonts.raleway(
//                             fontSize: w * 0.038,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.textPrimaryColor,
//                           ),
//                         ),
//                       ],
//                     ),

//                     SizedBox(height: h * 0.012),

                  
//                     Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.all(w * 0.035),
//                       decoration: BoxDecoration(
//                         color: AppColors.scaffoldBg,
//                         borderRadius: BorderRadius.circular(w * 0.025),
//                       ),
//                       child: Text(
//                         _fcmToken ?? 'Generating token...',
//                         style: GoogleFonts.raleway(
//                           fontSize: w * 0.028,
//                           color: AppColors.textSecondaryColor,
//                           height: 1.5,
//                         ),
//                         maxLines: 4,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),

//                     SizedBox(height: h * 0.012),

                   
//                     Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton.icon(
//                             onPressed: () {
//                               if (_fcmToken != null) {
//                                 Clipboard.setData(
//                                     ClipboardData(text: _fcmToken!));
//                                 Get.snackbar(
//                                   '✅ Copied',
//                                   'FCM token copied to clipboard',
//                                   snackPosition: SnackPosition.BOTTOM,
//                                   duration: const Duration(seconds: 2),
//                                 );
//                               }
//                             },
//                             icon: Icon(Icons.copy_rounded, size: w * 0.04),
//                             label: Text(
//                               'Copy Token',
//                               style: GoogleFonts.raleway(
//                                 fontSize: w * 0.032,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: AppColors.primaryColor,
//                               side: BorderSide(color: AppColors.primaryColor),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.circular(w * 0.025),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: w * 0.03),
//                         Expanded(
//                           child: OutlinedButton.icon(
//                             onPressed: _loadFcmToken,
//                             icon: Icon(Icons.refresh_rounded, size: w * 0.04),
//                             label: Text(
//                               'Refresh',
//                               style: GoogleFonts.raleway(
//                                 fontSize: w * 0.032,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: AppColors.textSecondaryColor,
//                               side:
//                                   BorderSide(color: AppColors.dividerColor),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.circular(w * 0.025),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: h * 0.015),

//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(w * 0.045),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(w * 0.04),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.04),
//                       blurRadius: 8,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(w * 0.025),
//                           decoration: BoxDecoration(
//                             color: AppColors.primaryColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(w * 0.025),
//                           ),
//                           child: Icon(
//                             Icons.send_rounded,
//                             color: AppColors.primaryColor,
//                             size: w * 0.05,
//                           ),
//                         ),
//                         SizedBox(width: w * 0.03),
//                         Text(
//                           'Test Notification',
//                           style: GoogleFonts.raleway(
//                             fontSize: w * 0.038,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.textPrimaryColor,
//                           ),
//                         ),
//                       ],
//                     ),

//                     SizedBox(height: h * 0.008),

//                     Text(
//                       'Fires a local notification with product_id: 5. Tap it to verify navigation goes to Product Detail.',
//                       style: GoogleFonts.raleway(
//                         fontSize: w * 0.03,
//                         color: AppColors.textSecondaryColor,
//                         height: 1.5,
//                       ),
//                     ),

//                     SizedBox(height: h * 0.014),

//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                         onPressed: () async {
//                           await NotificationService.showAddToCartNotification(
//                             productId: 5,
//                             productTitle: 'Test Product Notification',
//                           );
                        
//                         },
//                         icon: Icon(Icons.send_rounded, size: w * 0.045),
//                         label: Text(
//                           'Send Test Notification',
//                           style: GoogleFonts.raleway(
//                             fontSize: w * 0.035,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primaryColor,
//                           foregroundColor: Colors.white,
//                           padding: EdgeInsets.symmetric(
//                             vertical: h * 0.016,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(w * 0.03),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: h * 0.03),

//                     GestureDetector(
//                 onTap: () => Get.dialog(AlertDialog(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                   title: Text('Logout',
//                       style:
//                           GoogleFonts.raleway(fontWeight: FontWeight.w700)),
//                   content: Text('Are you sure you want to logout?',
//                       style: GoogleFonts.raleway()),
//                   actions: [
//                     TextButton(
//                         onPressed: () => Get.back(),
//                         child: Text('Cancel',
//                             style:
//                                 GoogleFonts.raleway(color: Colors.grey))),
//                     TextButton(
//                         onPressed: () {
//                           Get.back();
//                           authController.logout();
//                         },
//                         child: Text('Logout',
//                             style: GoogleFonts.raleway(
//                                 color: AppColors.errorColor,
//                                 fontWeight: FontWeight.w700))),
//                   ],
//                 )),
//                 child: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(vertical: h * 0.02),
//                   decoration: BoxDecoration(
//                     color: AppColors.errorColor.withOpacity(0.08),
//                     borderRadius: BorderRadius.circular(w * 0.04),
//                     border: Border.all(
//                         color: AppColors.errorColor.withOpacity(0.3)),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.logout_rounded,
//                           color: AppColors.errorColor, size: w * 0.055),
//                       SizedBox(width: w * 0.03),
//                       Text(
//                         'Logout',
//                         style: GoogleFonts.raleway(
//                           fontSize: w * 0.042,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.errorColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               SizedBox(height: h * 0.04),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// class _SettingsItem extends StatelessWidget {
//   final IconData icon;
//   final Color iconColor;
//   final String title;
//   final String subtitle;
//   final VoidCallback onTap;

//   const _SettingsItem({
//     required this.icon,
//     required this.iconColor,
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(w * 0.045),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(w * 0.04),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 8,
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: EdgeInsets.all(w * 0.025),
//               decoration: BoxDecoration(
//                 color: iconColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(w * 0.025),
//               ),
//               child: Icon(icon, color: iconColor, size: w * 0.05),
//             ),
//             SizedBox(width: w * 0.04),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title,
//                       style: GoogleFonts.raleway(
//                           fontSize: w * 0.038,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimaryColor)),
//                   Text(subtitle,
//                       style: GoogleFonts.raleway(
//                           fontSize: w * 0.03,
//                           color: AppColors.textSecondaryColor)),
//                 ],
//               ),
//             ),
//             Icon(Icons.arrow_forward_ios_rounded,
//                 color: AppColors.textHintColor, size: w * 0.04),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shoppe/controllers/setting_controller.dart';
import '../../constants/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../services/notification_service.dart';
import '../../services/shared_prefs_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(SettingsController());

    final authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.025),

              // ── Header ──────────────────────────────────────────
              Text(
                'Settings',
                style: GoogleFonts.raleway(
                  fontSize: w * 0.07,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimaryColor,
                  letterSpacing: -0.5,
                ),
              ),

              SizedBox(height: h * 0.03),
              _SettingsItem(
                icon: Icons.info_rounded,
                iconColor: AppColors.primaryColor,
                title: 'About Shoppe',
                subtitle: 'Discover products you love',
                onTap: () {
                  Get.dialog(AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('About Shoppe',
                        style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w700)),
                    content: Text(
                        'Shoppe is a beautiful eCommerce app built with Flutter & GetX.',
                        style: GoogleFonts.raleway()),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text('OK',
                            style: GoogleFonts.raleway(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ));
                },
              ),

              SizedBox(height: h * 0.03),

              Text(
                'FIREBASE TESTING',
                style: GoogleFonts.raleway(
                  fontSize: w * 0.033,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondaryColor,
                  letterSpacing: 1.2,
                ),
              ),

              SizedBox(height: h * 0.012),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * 0.045),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.04),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(w * 0.025),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B00).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(w * 0.025),
                          ),
                          child: Icon(
                            Icons.notifications_active_rounded,
                            color: const Color(0xFFFF6B00),
                            size: w * 0.05,
                          ),
                        ),
                        SizedBox(width: w * 0.03),
                        Text(
                          'FCM Device Token',
                          style: GoogleFonts.raleway(
                            fontSize: w * 0.038,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: h * 0.012),

                      Obx(() {
                      final token = ctrl.fcmToken.value;
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(w * 0.035),
                        decoration: BoxDecoration(
                          color: AppColors.scaffoldBg,
                          borderRadius: BorderRadius.circular(w * 0.025),
                        ),
                        child: token == null
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.04,
                                    height: w * 0.04,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.03),
                                  Text(
                                    'Fetching token…',
                                    style: GoogleFonts.raleway(
                                      fontSize: w * 0.03,
                                      color: AppColors.textSecondaryColor,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                token,
                                style: GoogleFonts.raleway(
                                  fontSize: w * 0.028,
                                  color: AppColors.textSecondaryColor,
                                  height: 1.5,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                      );
                    }),

                    SizedBox(height: h * 0.012),

                   
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              final token = ctrl.fcmToken.value;
                              if (token != null &&
                                  token != 'Token unavailable') {
                                Clipboard.setData(
                                    ClipboardData(text: token));
                                Get.snackbar(
                                  '✅ Copied',
                                  'FCM token copied to clipboard',
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: const Duration(seconds: 2),
                                );
                              }
                            },
                            icon: Icon(Icons.copy_rounded, size: w * 0.04),
                            label: Text('Copy Token',
                                style: GoogleFonts.raleway(
                                    fontSize: w * 0.032,
                                    fontWeight: FontWeight.w600)),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primaryColor,
                              side:
                                  BorderSide(color: AppColors.primaryColor),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(w * 0.025)),
                            ),
                          ),
                        ),
                      
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.015),

                    Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * 0.045),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.04),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(w * 0.025),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(w * 0.025),
                          ),
                          child: Icon(Icons.send_rounded,
                              color: AppColors.primaryColor, size: w * 0.05),
                        ),
                        SizedBox(width: w * 0.03),
                        Text(
                          'Test Notification',
                          style: GoogleFonts.raleway(
                            fontSize: w * 0.038,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.008),
                    Text(
                      'Fires a local notification with product_id: 5. Tap it to verify navigation goes to Product Detail.',
                      style: GoogleFonts.raleway(
                        fontSize: w * 0.03,
                        color: AppColors.textSecondaryColor,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: h * 0.014),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await NotificationService
                              .showAddToCartNotification(
                            productId: 5,
                            productTitle: 'Test Product Notification',
                          );
                        
                        },
                        icon: Icon(Icons.send_rounded, size: w * 0.045),
                        label: Text('Send Test Notification',
                            style: GoogleFonts.raleway(
                                fontSize: w * 0.035,
                                fontWeight: FontWeight.w700)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          padding:
                              EdgeInsets.symmetric(vertical: h * 0.016),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(w * 0.03)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.03),

                      GestureDetector(
                onTap: () => Get.dialog(AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Text('Logout',
                      style:
                          GoogleFonts.raleway(fontWeight: FontWeight.w700)),
                  content: Text('Are you sure you want to logout?',
                      style: GoogleFonts.raleway()),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text('Cancel',
                          style: GoogleFonts.raleway(color: Colors.grey)),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        authController.logout();
                      },
                      child: Text('Logout',
                          style: GoogleFonts.raleway(
                              color: AppColors.errorColor,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                )),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: h * 0.02),
                  decoration: BoxDecoration(
                    color: AppColors.errorColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(w * 0.04),
                    border: Border.all(
                        color: AppColors.errorColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_rounded,
                          color: AppColors.errorColor, size: w * 0.055),
                      SizedBox(width: w * 0.03),
                      Text(
                        'Logout',
                        style: GoogleFonts.raleway(
                          fontSize: w * 0.042,
                          fontWeight: FontWeight.w700,
                          color: AppColors.errorColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: h * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Reusable settings row ─────────────────────────────────────────────────────

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(w * 0.045),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * 0.04),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04), blurRadius: 8),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(w * 0.025),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(w * 0.025),
              ),
              child: Icon(icon, color: iconColor, size: w * 0.05),
            ),
            SizedBox(width: w * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.raleway(
                          fontSize: w * 0.038,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryColor)),
                  Text(subtitle,
                      style: GoogleFonts.raleway(
                          fontSize: w * 0.03,
                          color: AppColors.textSecondaryColor)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                color: AppColors.textHintColor, size: w * 0.04),
          ],
        ),
      ),
    );
  }
}