import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/favourites_controller.dart';
import '../../routes/app_routes.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final favController = Get.find<FavouritesController>();
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.025, w * 0.05, 0),
              child: Text('Favourites', style: GoogleFonts.raleway(fontSize: w * 0.07, fontWeight: FontWeight.w900, color: AppColors.textPrimaryColor, letterSpacing: -0.5)),
            ),
            SizedBox(height: h * 0.02),
            Expanded(
              child: Obx(() {
                if (favController.favourites.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border_rounded, size: w * 0.25, color: AppColors.greyColor.withOpacity(0.4)),
                        SizedBox(height: h * 0.025),
                        Text('No favourites yet', style: GoogleFonts.raleway(fontSize: w * 0.05, fontWeight: FontWeight.w700, color: AppColors.textPrimaryColor)),
                        SizedBox(height: h * 0.01),
                        Text('Tap ♥ on any product to save it', style: GoogleFonts.raleway(fontSize: w * 0.036, color: AppColors.textSecondaryColor)),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                  itemCount: favController.favourites.length,
                  separatorBuilder: (_, __) => SizedBox(height: h * 0.015),
                  itemBuilder: (context, index) {
                    final product = favController.favourites[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.productDetail, arguments: {'product': product}),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(w * 0.04), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                        child: Padding(
                          padding: EdgeInsets.all(w * 0.04),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(w * 0.03),
                                child: Container(
                                  width: w * 0.22, height: w * 0.22,
                                  color: AppColors.lightGreyColor,
                                  child: CachedNetworkImage(imageUrl: product.image, fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(width: w * 0.04),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.raleway(fontSize: w * 0.034, fontWeight: FontWeight.w600, color: AppColors.textPrimaryColor)),
                                    SizedBox(height: 6),
                                    Text('\$${product.price.toStringAsFixed(2)}', style: GoogleFonts.raleway(fontSize: w * 0.042, fontWeight: FontWeight.w800, color: AppColors.primaryColor)),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Obx(() => GestureDetector(
                                          onTap: () => cartController.addToCart(product),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: 6),
                                            decoration: BoxDecoration(color: cartController.isInCart(product.id) ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                            child: Text(
                                              cartController.isInCart(product.id) ? 'In Cart ✓' : 'Add to Cart',
                                              style: GoogleFonts.raleway(fontSize: w * 0.028, fontWeight: FontWeight.w700, color: cartController.isInCart(product.id) ? Colors.white : AppColors.primaryColor),
                                            ),
                                          ),
                                        )),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () => favController.removeFavourite(product.id),
                                          child: Icon(Icons.delete_outline_rounded, color: AppColors.errorColor, size: w * 0.055),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}