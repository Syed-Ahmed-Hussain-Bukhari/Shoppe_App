import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/app_colors.dart';
import '../models/product_model.dart';
import '../controllers/cart_controller.dart';
import '../controllers/favourites_controller.dart';
import '../routes/app_routes.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final cartController = Get.find<CartController>();
    final favController = Get.find<FavouritesController>();

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.productDetail, arguments: {'product': product}),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(w * 0.04),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(w * 0.04), topRight: Radius.circular(w * 0.04)),
                    child: CachedNetworkImage(
                      imageUrl: product.image, fit: BoxFit.contain, width: double.infinity,
                      placeholder: (_, __) => Container(color: AppColors.lightGreyColor, child: Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryColor.withOpacity(0.5)))),
                    ),
                  ),
            
                  Positioned(
                    top: 8, left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.015, vertical: h * 0.004),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(w * 0.02), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4)]),
                      child: Row(
                        children: [
                          Icon(Icons.star_rounded, color: AppColors.starColor, size: w * 0.03),
                          SizedBox(width: w * 0.01),
                          Text(product.rating.rate.toStringAsFixed(1), style: GoogleFonts.raleway(fontSize: w * 0.028, fontWeight: FontWeight.w700, color: AppColors.textPrimaryColor)),
                        ],
                      ),
                    ),
                  ),
                      Positioned(
                    top: 6, right: 6,
                    child: Obx(() => GestureDetector(
                      onTap: () => favController.toggleFavourite(product),
                      child: Container(
                        padding: EdgeInsets.all(w * 0.015),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4)]),
                        child: Icon(
                          favController.isFavourite(product.id) ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: favController.isFavourite(product.id) ? AppColors.errorColor : AppColors.greyColor,
                          size: w * 0.045,
                        ),
                      ),
                    )),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(w * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.raleway(fontSize: w * 0.032, fontWeight: FontWeight.w600, color: AppColors.textPrimaryColor, height: 1.3)),
                    const Spacer(),
                    Row(
                      children: [
                        Text('\$${product.price.toStringAsFixed(2)}', style: GoogleFonts.raleway(fontSize: w * 0.038, fontWeight: FontWeight.w800, color: AppColors.primaryColor)),
                        const Spacer(),
                        Obx(() => GestureDetector(
                          onTap: () => cartController.addToCart(product),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: w * 0.08, height: w * 0.08,
                            decoration: BoxDecoration(
                              color: cartController.isInCart(product.id) ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(w * 0.02),
                            ),
                            child: Icon(
                              cartController.isInCart(product.id) ? Icons.check : Icons.add,
                              color: cartController.isInCart(product.id) ? Colors.white : AppColors.primaryColor,
                              size: w * 0.045,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}