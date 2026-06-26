import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: h * 0.32,
            pinned: true,
            backgroundColor: AppColors.primaryColor,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryColor, AppColors.primaryColor.withOpacity(0.7)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: h * 0.03),
                      Container(
                        width: 90, height: 90,
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3), width: 4), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)]),
                        alignment: Alignment.center,
                        child: Text('A', style: GoogleFonts.raleway(fontSize: 40, fontWeight: FontWeight.w900, color: AppColors.primaryColor)),
                      ),
                      SizedBox(height: h * 0.015),
                      Text(AuthController.userName, style: GoogleFonts.raleway(color: Colors.white, fontSize: w * 0.055, fontWeight: FontWeight.bold)),
                      SizedBox(height: h * 0.006),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 4),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                        child: Text('Customer', style: GoogleFonts.raleway(color: Colors.white, fontSize: w * 0.032, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(w * 0.05),
              child: Column(
                children: [
                 
                  Container(
                    padding: EdgeInsets.all(w * 0.04),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                    child: Column(
                      children: [
                        _InfoRow(icon: Icons.email_outlined, label: 'Email', value: AuthController.userEmail),
                        Divider(color: Colors.grey.shade100),
                        _InfoRow(icon: Icons.person_outline, label: 'Name', value: AuthController.userName),
                        Divider(color: Colors.grey.shade100),
                        _InfoRow(icon: Icons.verified_user_outlined, label: 'Account', value: 'Active'),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  _ProfileOption(icon: Icons.settings_rounded, title: 'Settings', subtitle: 'App preferences', onTap: () => Get.toNamed(AppRoutes.settings)),
                  SizedBox(height: h * 0.015),
                  _ProfileOption(
                    icon: Icons.logout_rounded,
                    title: 'Logout',
                    subtitle: 'Sign out of your account',
                    isDestructive: true,
                    onTap: () => Get.dialog(AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: Text('Logout', style: GoogleFonts.raleway(fontWeight: FontWeight.w700)),
                      content: Text('Are you sure?', style: GoogleFonts.raleway()),
                      actions: [
                        TextButton(onPressed: () => Get.back(), child: Text('Cancel', style: GoogleFonts.raleway(color: Colors.grey))),
                        TextButton(onPressed: () { Get.back(); authController.logout(); }, child: Text('Logout', style: GoogleFonts.raleway(color: AppColors.errorColor, fontWeight: FontWeight.w700))),
                      ],
                    )),
                  ),

                  SizedBox(height: h * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: AppColors.primaryColor, size: 20),
          ),
          SizedBox(width: w * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.raleway(fontSize: w * 0.03, color: AppColors.textSecondaryColor)),
                Text(value, style: GoogleFonts.raleway(fontSize: w * 0.038, fontWeight: FontWeight.w600, color: AppColors.textPrimaryColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ProfileOption({required this.icon, required this.title, required this.subtitle, required this.onTap, this.isDestructive = false});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final color = isDestructive ? AppColors.errorColor : AppColors.primaryColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: w * 0.035),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
        child: Row(
          children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 22)),
            SizedBox(width: w * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.raleway(fontWeight: FontWeight.w600, fontSize: w * 0.04, color: isDestructive ? AppColors.errorColor : AppColors.textPrimaryColor)),
                  Text(subtitle, style: GoogleFonts.raleway(fontSize: w * 0.03, color: AppColors.textSecondaryColor)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.greyColor),
          ],
        ),
      ),
    );
  }
}