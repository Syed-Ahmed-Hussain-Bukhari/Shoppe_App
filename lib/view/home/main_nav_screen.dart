// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shoppe/view/cart/cart_screen.dart';
// import 'package:shoppe/view/favourites/favourites_screen.dart';
// import 'package:shoppe/view/products/product_list_screen.dart';
// import 'package:shoppe/view/profile/profile_screen.dart';
// import '../../constants/app_colors.dart';
// import '../../controllers/auth_controller.dart';
// import '../../controllers/cart_controller.dart';
// import '../../controllers/favourites_controller.dart';
// import '../../controllers/nav_controller.dart';
// import '../../routes/app_routes.dart';
// import '../../services/notification_service.dart';

// class MainNavScreen extends StatefulWidget {
//   const MainNavScreen({super.key});

//   @override
//   State<MainNavScreen> createState() => _MainNavScreenState();
// }

// class _MainNavScreenState extends State<MainNavScreen> {
//   @override
  

//   @override
//   Widget build(BuildContext context) {
//     final navController = Get.put(NavController());
    
//     Get.put(AuthController());
//     Get.put(CartController());
//     Get.put(FavouritesController());

//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;

//     final pages = [
//       const ProductListScreen(),
//       const CartScreen(),
//       const FavouritesScreen(),
//       const ProfileScreen(),
//     ];

//     return Obx(() => Scaffold(
//           drawer: _AppDrawer(),
//           body: IndexedStack(
//             index: navController.selectedIndex.value,
//             children: pages,
//           ),
//           bottomNavigationBar: Container(
//             decoration: BoxDecoration(
//               color: AppColors.whiteColor,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.08),
//                   blurRadius: 20,
//                   offset: const Offset(0, -4),
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               child: SizedBox(
//                 height: h * 0.075,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _NavItem(icon: Icons.home_rounded, label: 'Home', index: 0, controller: navController),
//                     _NavItem(icon: Icons.shopping_cart_rounded, label: 'Cart', index: 1, controller: navController, showCartBadge: true),
//                     _NavItem(icon: Icons.favorite_rounded, label: 'Favourites', index: 2, controller: navController, showFavBadge: true),
//                     _NavItem(icon: Icons.person_rounded, label: 'Profile', index: 3, controller: navController),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }

// class _AppDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     final navController = Get.find<NavController>();
//     final authController = Get.find<AuthController>();

//     return Drawer(
//       backgroundColor: Colors.white,
//       child: Column(
//         children: [
     
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [AppColors.primaryColor, AppColors.primaryColor.withOpacity(0.7)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: SafeArea(
//               bottom: false,
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.025, w * 0.05, h * 0.03),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: w * 0.16,
//                       height: w * 0.16,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10)],
//                       ),
//                       alignment: Alignment.center,
//                       child: Text(
//                         'A',
//                         style: GoogleFonts.raleway(
//                           fontSize: w * 0.07,
//                           fontWeight: FontWeight.w900,
//                           color: AppColors.primaryColor,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: h * 0.015),
//                     Text(
//                       'Ahmed',
//                       style: GoogleFonts.raleway(
//                         color: Colors.white,
//                         fontSize: w * 0.048,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     SizedBox(height: h * 0.004),
//                     Text(
//                       'ahmed24@gmail.com',
//                       style: GoogleFonts.raleway(
//                         color: Colors.white70,
//                         fontSize: w * 0.032,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.symmetric(vertical: h * 0.02),
//               children: [
//                 _DrawerItem(
//                   icon: Icons.home_rounded,
//                   label: 'Home',
//                   onTap: () { Get.back(); navController.changePage(0); },
//                 ),
//                 _DrawerItem(
//                   icon: Icons.shopping_cart_rounded,
//                   label: 'Cart',
//                   onTap: () { Get.back(); navController.changePage(1); },
//                 ),
//                 _DrawerItem(
//                   icon: Icons.favorite_rounded,
//                   label: 'Favourites',
//                   onTap: () { Get.back(); navController.changePage(2); },
//                 ),
//                 _DrawerItem(
//                   icon: Icons.person_rounded,
//                   label: 'Profile',
//                   onTap: () { Get.back(); navController.changePage(3); },
//                 ),
//                 Divider(color: Colors.grey.shade200, thickness: 1, indent: 16, endIndent: 16),
//                 _DrawerItem(
//                   icon: Icons.settings_rounded,
//                   label: 'Settings',
//                   onTap: () { Get.back(); Get.toNamed(AppRoutes.settings); },
//                 ),
//               ],
//             ),
//           ),

//           SafeArea(
//             top: false,
//             child: Padding(
//               padding: EdgeInsets.all(w * 0.04),
//               child: InkWell(
//                 onTap: () {
//                   Get.back();
//                   Get.dialog(AlertDialog(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                     title: Text('Logout', style: GoogleFonts.raleway(fontWeight: FontWeight.w700)),
//                     content: Text('Are you sure you want to logout?', style: GoogleFonts.raleway()),
//                     actions: [
//                       TextButton(onPressed: () => Get.back(), child: Text('Cancel', style: GoogleFonts.raleway(color: Colors.grey))),
//                       TextButton(
//                         onPressed: () { Get.back(); authController.logout(); },
//                         child: Text('Logout', style: GoogleFonts.raleway(color: AppColors.errorColor, fontWeight: FontWeight.w700)),
//                       ),
//                     ],
//                   ));
//                 },
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.016),
//                   decoration: BoxDecoration(
//                     color: AppColors.errorColor.withOpacity(0.08),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: AppColors.errorColor.withOpacity(0.3)),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.logout_rounded, color: AppColors.errorColor, size: w * 0.055),
//                       SizedBox(width: w * 0.03),
//                       Text('Logout', style: GoogleFonts.raleway(color: AppColors.errorColor, fontWeight: FontWeight.w700, fontSize: w * 0.04)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DrawerItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;

//   const _DrawerItem({required this.icon, required this.label, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     return ListTile(
//       leading: Icon(icon, color: AppColors.primaryColor, size: w * 0.06),
//       title: Text(label, style: GoogleFonts.raleway(fontWeight: FontWeight.w600, fontSize: w * 0.04, color: AppColors.textPrimaryColor)),
//       onTap: onTap,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       contentPadding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: 2),
//     );
//   }
// }

// class _NavItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final int index;
//   final NavController controller;
//   final bool showCartBadge;
//   final bool showFavBadge;

//   const _NavItem({
//     required this.icon,
//     required this.label,
//     required this.index,
//     required this.controller,
//     this.showCartBadge = false,
//     this.showFavBadge = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final cartController = showCartBadge ? Get.find<CartController>() : null;
//     final favController = showFavBadge ? Get.find<FavouritesController>() : null;

//     return Obx(() {
//       final isSelected = controller.selectedIndex.value == index;
//       final cartCount = cartController?.totalItemCount ?? 0;
//       final favCount = favController?.favourites.length ?? 0;
//       final badgeCount = showCartBadge ? cartCount : (showFavBadge ? favCount : 0);

//       return GestureDetector(
//         onTap: () => controller.changePage(index),
//         behavior: HitTestBehavior.opaque,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: w * 0.02),
//           decoration: BoxDecoration(
//             color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : Colors.transparent,
//             borderRadius: BorderRadius.circular(w * 0.03),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Icon(icon, color: isSelected ? AppColors.primaryColor : AppColors.greyColor, size: w * 0.065),
//                   if (badgeCount > 0)
//                     Positioned(
//                       top: -w * 0.01,
//                       right: -w * 0.015,
//                       child: Container(
//                         width: w * 0.042,
//                         height: w * 0.042,
//                         decoration: BoxDecoration(color: AppColors.badgeColor, shape: BoxShape.circle),
//                         alignment: Alignment.center,
//                         child: Text(
//                           badgeCount > 9 ? '9+' : '$badgeCount',
//                           style: TextStyle(color: Colors.white, fontSize: w * 0.022, fontWeight: FontWeight.w800),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//               SizedBox(height: w * 0.01),
//               Text(
//                 label,
//                 style: TextStyle(
//                   color: isSelected ? AppColors.primaryColor : AppColors.greyColor,
//                   fontSize: w * 0.025,
//                   fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe/controllers/main_nav_controller.dart';
import 'package:shoppe/view/cart/cart_screen.dart';
import 'package:shoppe/view/favourites/favourites_screen.dart';
import 'package:shoppe/view/products/product_list_screen.dart';
import 'package:shoppe/view/profile/profile_screen.dart';
import 'package:shoppe/widgets/drawer.dart';
import '../../constants/app_colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/favourites_controller.dart';
import '../../controllers/nav_controller.dart';

class MainNavScreen extends StatelessWidget {
  const MainNavScreen({super.key});

  static const List<Widget> _pages = [
    ProductListScreen(),
    CartScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(MainNavController());
    final w    = MediaQuery.of(context).size.width;
    final h    = MediaQuery.of(context).size.height;

    return Obx(() => Scaffold(
          drawer: const AppDrawer(),
          body: IndexedStack(
            index: ctrl.nav.selectedIndex.value,
            children: _pages,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                height: h * 0.075,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(icon: Icons.home_rounded,           label: 'Home',       index: 0),
                    _NavItem(icon: Icons.shopping_cart_rounded,  label: 'Cart',       index: 1, showCartBadge: true),
                    _NavItem(icon: Icons.favorite_rounded,       label: 'Favourites', index: 2, showFavBadge: true),
                    _NavItem(icon: Icons.person_rounded,         label: 'Profile',    index: 3),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool showCartBadge;
  final bool showFavBadge;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    this.showCartBadge = false,
    this.showFavBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final w              = MediaQuery.of(context).size.width;
    final navController  = Get.find<NavController>();
    final cartController = showCartBadge ? Get.find<CartController>() : null;
    final favController  = showFavBadge  ? Get.find<FavouritesController>() : null;

    return Obx(() {
      final isSelected  = navController.selectedIndex.value == index;
      final cartCount   = cartController?.totalItemCount ?? 0;
      final favCount    = favController?.favourites.length ?? 0;
      final badgeCount  = showCartBadge ? cartCount : (showFavBadge ? favCount : 0);

      return GestureDetector(
        onTap: () => navController.changePage(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
              horizontal: w * 0.04, vertical: w * 0.02),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(w * 0.03),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    icon,
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.greyColor,
                    size: w * 0.065,
                  ),
                  if (badgeCount > 0)
                    Positioned(
                      top: -w * 0.01,
                      right: -w * 0.015,
                      child: Container(
                        width: w * 0.042,
                        height: w * 0.042,
                        decoration: BoxDecoration(
                          color: AppColors.badgeColor,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          badgeCount > 9 ? '9+' : '$badgeCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.022,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: w * 0.01),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.greyColor,
                  fontSize: w * 0.025,
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}