import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/custom_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/custom_size.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final w = size.customWidth(context);
    final h = size.customHeight(context);
    final authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
        
          Positioned(
            top: -h * 0.06,
            left: -w * 0.15,
            child: Container(
              width: w * 0.85,
              height: h * 0.42,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: h * 0.1,
            left: -w * 0.08,
            child: Container(
              width: w * 0.65,
              height: h * 0.28,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: h * 0.2,
            right: -w * 0.12,
            child: Container(
              width: w * 0.35,
              height: h * 0.2,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h * 0.32),

                  Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.07),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           SizedBox(height: h * 0.015),
                      
                          Text(
                            'Login',
                            style: GoogleFonts.raleway(
                              fontSize: w * 0.1,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimaryColor,
                              letterSpacing: -1,
                            ),
                          ),

                          SizedBox(height: h * 0.005),

                          Row(
                            children: [
                              Text(
                                'Good to see you back!',
                                style: GoogleFonts.raleway(
                                  fontSize: w * 0.038,
                                  color: AppColors.textSecondaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: w * 0.015),
                              Text(
                                '♥',
                                style: TextStyle(
                                  fontSize: w * 0.038,
                                  color: AppColors.textPrimaryColor,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: h * 0.04),

                        
                          _buildTextField(
                            context: context,
                            controller: _emailController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Email is required';
                              }
                              if (!val.contains('@')) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: h * 0.02),

                           Obx(() => _buildPasswordField(
                                context: context,
                                controller: _passwordController,
                                hintText: 'Password',
                                obscure: authController.isPasswordHidden.value,
                                onToggle:
                                    authController.togglePasswordVisibility,
                                validator: (val) =>
                                    val == null || val.isEmpty
                                        ? 'Password is required'
                                        : null,
                              )),

                          SizedBox(height: h * 0.045),

                          
                          Obx(() => CustomButton(
                                title: 'Login',
                                loading: authController.isLoading.value,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    authController.login(
                                      _emailController.text.trim(),
                                      _passwordController.text,
                                    );
                                  }
                                },
                              )),

                        
                          SizedBox(height: h * 0.02),
                          Container(
                            padding: EdgeInsets.all(w * 0.04),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.07),
                              borderRadius: BorderRadius.circular(w * 0.03),
                              border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.2),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '🔑 Demo Credentials',
                                  style: GoogleFonts.raleway(
                                    fontSize: w * 0.032,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                SizedBox(height: h * 0.006),
                                Text(
                                  'Email: ahmed24@gmail.com',
                                  style: GoogleFonts.raleway(
                                    fontSize: w * 0.03,
                                    color: AppColors.textSecondaryColor,
                                  ),
                                ),
                                Text(
                                  'Password: pass123',
                                  style: GoogleFonts.raleway(
                                    fontSize: w * 0.03,
                                    color: AppColors.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: h * 0.03),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      cursorColor: AppColors.primaryColor,
      style: GoogleFonts.raleway(
        fontSize: w * 0.04,
        color: AppColors.textPrimaryColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.raleway(
          fontSize: w * 0.04,
          color: AppColors.textHintColor,
        ),
        filled: true,
        fillColor: AppColors.lightGreyColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.035),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.035),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.035),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.035),
          borderSide: BorderSide(color: AppColors.errorColor, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: w * 0.05,
          vertical: h * 0.022,
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required bool obscure,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      cursorColor: AppColors.primaryColor,
      style: GoogleFonts.raleway(
        fontSize: w * 0.04,
        color: AppColors.textPrimaryColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.raleway(
          fontSize: w * 0.04,
          color: AppColors.textHintColor,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.greyColor,
            size: w * 0.055,
          ),
          onPressed: onToggle,
        ),
        filled: true,
        fillColor: AppColors.lightGreyColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.035),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.035),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.035),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.035),
          borderSide: BorderSide(color: AppColors.errorColor, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: w * 0.05,
          vertical: h * 0.022,
        ),
      ),
    );
  }
}