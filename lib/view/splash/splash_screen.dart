// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../constants/app_colors.dart';
// import '../../routes/app_routes.dart';
// import '../../services/shared_prefs_service.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late AnimationController _textController;
//   late Animation<double> _logoScale;
//   late Animation<double> _textOpacity;
//   late Animation<Offset> _textSlide;

//   @override
//   void initState() {
//     super.initState();

//     _logoController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     );

//     _textController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );

//     _logoScale = CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.elasticOut,
//     );

//     _textOpacity = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _textController, curve: Curves.easeIn),
//     );

//     _textSlide = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

//     _startAnimations();
//   }

//   void _startAnimations() async {
//     await Future.delayed(const Duration(milliseconds: 300));
//     _logoController.forward();
//     await Future.delayed(const Duration(milliseconds: 500));
//     _textController.forward();
//     await Future.delayed(const Duration(milliseconds: 1200));
//     _navigate();
//   }

//   Future<void> _navigate() async {
//     final loggedIn = await SharedPrefsService.isLoggedIn();
//     if (loggedIn) {
//       Get.offAllNamed(AppRoutes.mainNav);
//     } else {
//       Get.offAllNamed(AppRoutes.login);
//     }
//   }

//   @override
//   void dispose() {
//     _logoController.dispose();
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
          
//             ScaleTransition(
//               scale: _logoScale,
//               child: Container(
//                 width: w * 0.32,
//                 height: w * 0.32,
//                 decoration: BoxDecoration(
//                   color: AppColors.lightGreyColor,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.primaryColor.withOpacity(0.15),
//                       blurRadius: 30,
//                       spreadRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: Center(
//                   child: Image.asset(
//                     'assets/images/logo.png',
//                     width: w * 0.22,
//                     height: w * 0.22,
//                     fit: BoxFit.contain,
//                     errorBuilder: (context, error, stackTrace) => Icon(
//                       Icons.shopping_bag_rounded,
//                       color: AppColors.primaryColor,
//                       size: w * 0.18,
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(height: h * 0.04),

//             SlideTransition(
//               position: _textSlide,
//               child: FadeTransition(
//                 opacity: _textOpacity,
//                 child: Column(
//                   children: [
//                     Text(
//                       'Shoppe',
//                       style: GoogleFonts.raleway(
//                         fontSize: w * 0.1,
//                         fontWeight: FontWeight.w900,
//                         color: AppColors.textPrimaryColor,
//                         letterSpacing: -1,
//                       ),
//                     ),
//                     SizedBox(height: h * 0.01),
//                     Text(
//                       'Beautiful eCommerce UI Kit',
//                       style: GoogleFonts.raleway(
//                         fontSize: w * 0.038,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.textSecondaryColor,
//                       ),
//                     ),
//                     Text(
//                       'for your online store',
//                       style: GoogleFonts.raleway(
//                         fontSize: w * 0.038,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.textSecondaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             SizedBox(height: h * 0.12),

//             FadeTransition(
//               opacity: _textOpacity,
//               child: SizedBox(
//                 width: w * 0.08,
//                 height: w * 0.08,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2.5,
//                   color: AppColors.primaryColor.withOpacity(0.5),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe/controllers/splash_controller.dart';
import '../../constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(SplashController());

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
               ScaleTransition(
              scale: ctrl.logoScale,
              child: Container(
                width: w * 0.32,
                height: w * 0.32,
                decoration: BoxDecoration(
                  color: AppColors.lightGreyColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.15),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: w * 0.22,
                    height: w * 0.22,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.shopping_bag_rounded,
                      color: AppColors.primaryColor,
                      size: w * 0.18,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: h * 0.04),

                  SlideTransition(
              position: ctrl.textSlide,
              child: FadeTransition(
                opacity: ctrl.textOpacity,
                child: Column(
                  children: [
                    Text(
                      'Shoppe',
                      style: GoogleFonts.raleway(
                        fontSize: w * 0.1,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimaryColor,
                        letterSpacing: -1,
                      ),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      'Beautiful eCommerce UI Kit',
                      style: GoogleFonts.raleway(
                        fontSize: w * 0.038,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                    Text(
                      'for your online store',
                      style: GoogleFonts.raleway(
                        fontSize: w * 0.038,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.12),

     
            FadeTransition(
              opacity: ctrl.textOpacity,
              child: SizedBox(
                width: w * 0.08,
                height: w * 0.08,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.primaryColor.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}