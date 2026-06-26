
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe/constants/app_colors.dart';
import 'package:shoppe/controllers/auth_controller.dart';
import 'package:shoppe/controllers/nav_controller.dart';
import 'package:shoppe/routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final w             = MediaQuery.of(context).size.width;
    final h             = MediaQuery.of(context).size.height;
    final navController = Get.find<NavController>();
    final authController = Get.find<AuthController>();

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
      Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColor.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    w * 0.05, h * 0.025, w * 0.05, h * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: w * 0.16,
                      height: w * 0.16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'A',
                        style: GoogleFonts.raleway(
                          fontSize: w * 0.07,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.015),
                    Text(
                      'Ahmed',
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: w * 0.048,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: h * 0.004),
                    Text(
                      'ahmed24@gmail.com',
                      style: GoogleFonts.raleway(
                        color: Colors.white70,
                        fontSize: w * 0.032,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

         
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: h * 0.02),
              children: [
                _DrawerItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  onTap: () { Get.back(); navController.changePage(0); },
                ),
                _DrawerItem(
                  icon: Icons.shopping_cart_rounded,
                  label: 'Cart',
                  onTap: () { Get.back(); navController.changePage(1); },
                ),
                _DrawerItem(
                  icon: Icons.favorite_rounded,
                  label: 'Favourites',
                  onTap: () { Get.back(); navController.changePage(2); },
                ),
                _DrawerItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  onTap: () { Get.back(); navController.changePage(3); },
                ),
                Divider(
                  color: Colors.grey.shade200,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                _DrawerItem(
                  icon: Icons.settings_rounded,
                  label: 'Settings',
                  onTap: () { Get.back(); Get.toNamed(AppRoutes.settings); },
                ),
              ],
            ),
          ),

          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.all(w * 0.04),
              child: InkWell(
                onTap: () {
                  Get.back();
                  Get.dialog(AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('Logout',
                        style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w700)),
                    content: Text('Are you sure you want to logout?',
                        style: GoogleFonts.raleway()),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text('Cancel',
                            style:
                                GoogleFonts.raleway(color: Colors.grey)),
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
                  ));
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04, vertical: h * 0.016),
                  decoration: BoxDecoration(
                    color: AppColors.errorColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppColors.errorColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.logout_rounded,
                          color: AppColors.errorColor, size: w * 0.055),
                      SizedBox(width: w * 0.03),
                      Text(
                        'Logout',
                        style: GoogleFonts.raleway(
                          color: AppColors.errorColor,
                          fontWeight: FontWeight.w700,
                          fontSize: w * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor, size: w * 0.06),
      title: Text(
        label,
        style: GoogleFonts.raleway(
          fontWeight: FontWeight.w600,
          fontSize: w * 0.04,
          color: AppColors.textPrimaryColor,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding:
          EdgeInsets.symmetric(horizontal: w * 0.05, vertical: 2),
    );
  }
}
