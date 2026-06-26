import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shoppe/controllers/favourites_controller.dart';
import '../../constants/app_colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_controller.dart';
import '../../models/product_model.dart';
import '../../components/custom_button.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductController _productController;
  late CartController _cartController;

  @override
  void initState() {
    super.initState();
    _productController = Get.find<ProductController>();
    _cartController = Get.find<CartController>();
    

    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null && args['product'] != null) {
      _productController.setSelectedProduct(args['product'] as ProductModel);
    } else if (args != null && args['productId'] != null) {
      final id = args['productId'] as int;
      _productController.fetchProductById(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Obx(() {
        if (_productController.isDetailLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        final product = _productController.selectedProduct.value;
        if (product == null) {
          return const Center(child: Text('Product not found'));
        }

        return CustomScrollView(
          slivers: [
              SliverAppBar(
              expandedHeight: h * 0.45,
              pinned: true,
              backgroundColor: AppColors.lightGreyColor,
              elevation: 0,
              leading: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  margin: EdgeInsets.all(w * 0.025),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.textPrimaryColor,
                    size: w * 0.045,
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: AppColors.lightGreyColor,
                  padding: EdgeInsets.all(w * 0.1),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.contain,
                    placeholder: (_, __) => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor.withOpacity(0.4),
                        strokeWidth: 2,
                      ),
                    ),
                    errorWidget: (_, __, ___) => Icon(
                      Icons.image_not_supported_outlined,
                      size: w * 0.2,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
              ),
            ),

        SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(w * 0.07),
                    topRight: Radius.circular(w * 0.07),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  w * 0.06,
                  h * 0.03,
                  w * 0.06,
                  h * 0.12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
          
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.035,
                        vertical: h * 0.006,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(w * 0.02),
                      ),
                      child: Text(
                        product.category.toUpperCase(),
                        style: GoogleFonts.raleway(
                          fontSize: w * 0.028,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                          letterSpacing: 1,
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.015),

                    Text(
                      product.title,
                      style: GoogleFonts.raleway(
                        fontSize: w * 0.052,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimaryColor,
                        height: 1.3,
                      ),
                    ),

                    SizedBox(height: h * 0.02),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: GoogleFonts.raleway(
                            fontSize: w * 0.072,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textPrimaryColor,
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RatingBarIndicator(
                              rating: product.rating.rate,
                              itemBuilder: (context, _) => Icon(
                                Icons.star_rounded,
                                color: AppColors.starColor,
                              ),
                              itemCount: 5,
                              itemSize: w * 0.05,
                            ),
                            SizedBox(height: h * 0.004),
                            Text(
                              '${product.rating.count} reviews',
                              style: GoogleFonts.raleway(
                                fontSize: w * 0.03,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: h * 0.025),

                    Divider(color: AppColors.dividerColor, thickness: 1),

                    SizedBox(height: h * 0.02),

                    Text(
                      'Description',
                      style: GoogleFonts.raleway(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),

                    SizedBox(height: h * 0.012),

                    Text(
                      product.description,
                      style: GoogleFonts.raleway(
                        fontSize: w * 0.036,
                        color: AppColors.textSecondaryColor,
                        height: 1.6,
                      ),
                    ),

                    SizedBox(height: h * 0.025),

             
                    Row(
                      children: [
                        _InfoCard(
                          icon: Icons.star_rounded,
                          iconColor: AppColors.starColor,
                          label: 'Rating',
                          value: product.rating.rate.toStringAsFixed(1),
                        ),
                        SizedBox(width: w * 0.03),
                        _InfoCard(
                          icon: Icons.people_alt_rounded,
                          iconColor: AppColors.primaryColor,
                          label: 'Reviews',
                          value: '${product.rating.count}',
                        ),
                        SizedBox(width: w * 0.03),
                        _InfoCard(
                          icon: Icons.local_shipping_outlined,
                          iconColor: AppColors.successColor,
                          label: 'Delivery',
                          value: 'Free',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),

      bottomNavigationBar: Obx(() {
        final favController = Get.find<FavouritesController>();
        final product = _productController.selectedProduct.value;
        if (product == null) return const SizedBox();

        return Container(
          padding: EdgeInsets.fromLTRB(
            w * 0.06,
            h * 0.015,
            w * 0.06,
            h * 0.035,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Wishlist button
              // Container(
              //   width: w * 0.14,
              //   height: w * 0.14,
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: AppColors.dividerColor,
              //       width: 1.5,
              //     ),
              //     borderRadius: BorderRadius.circular(w * 0.035),
              //   ),
              //   child: Icon(
              //     Icons.favorite_border_rounded,
              //     color: AppColors.textSecondaryColor,
              //     size: w * 0.06,
              //   ),
              // ),

      Obx(
  () => GestureDetector(
    onTap: () => favController.toggleFavourite(product),
    child: Container(
      width: w * 0.14,
      height: w * 0.14,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.dividerColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(w * 0.035),
      ),
      child: Icon(
        favController.isFavourite(product.id)
            ? Icons.favorite_rounded
            : Icons.favorite_border_rounded,
        color: favController.isFavourite(product.id)
            ? AppColors.errorColor
            : AppColors.textSecondaryColor,
        size: w * 0.06,
      ),
    ),
  ),
),
              SizedBox(width: w * 0.04),

              
              Expanded(
                child: Obx(() => CustomButton(
                      title: _cartController.isInCart(product.id)
                          ? 'Remove from Cart'
                          : 'Add to Cart',
                      color: _cartController.isInCart(product.id)
                          ? AppColors.errorColor
                          : AppColors.primaryColor,
                      icon: Icon(
                        _cartController.isInCart(product.id)
                            ? Icons.remove_shopping_cart_outlined
                            : Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: w * 0.05,
                      ),
                      onTap: () {
                        if (_cartController.isInCart(product.id)) {
                          _cartController.removeFromCart(product.id);
                        } else {
                          _cartController.addToCart(product);
                        }
                      },
                    )),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: h * 0.015,
          horizontal: w * 0.02,
        ),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBg,
          borderRadius: BorderRadius.circular(w * 0.03),
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: w * 0.055),
            SizedBox(height: h * 0.006),
            Text(
              value,
              style: GoogleFonts.raleway(
                fontSize: w * 0.038,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimaryColor,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.raleway(
                fontSize: w * 0.028,
                color: AppColors.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}