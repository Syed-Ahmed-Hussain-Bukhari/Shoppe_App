import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_controller.dart';
import '../../widgets/product_card.dart';
import '../../widgets/shimmer_card.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final controller = Get.put(ProductController());
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.025, w * 0.05, 0),
              child: Row(
                children: [
                
                  GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Container(
                      width: w * 0.105,
                      height: w * 0.105,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(w * 0.03),
                      ),
                      child: Icon(Icons.menu_rounded, color: Colors.white, size: w * 0.055),
                    ),
                  ),
                  SizedBox(width: w * 0.035),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Discover', style: GoogleFonts.raleway(fontSize: w * 0.065, fontWeight: FontWeight.w900, color: AppColors.textPrimaryColor, letterSpacing: -0.5)),
                      Text('Find your perfect item', style: GoogleFonts.raleway(fontSize: w * 0.032, color: AppColors.textSecondaryColor)),
                    ],
                  ),
                  const Spacer(),
                  
                  Obx(() => Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: w * 0.11,
                        height: w * 0.11,
                        decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(w * 0.03)),
                        child: Icon(Icons.shopping_bag_outlined, color: Colors.white, size: w * 0.058),
                      ),
                      if (cartController.totalItemCount > 0)
                        Positioned(
                          top: -w * 0.01, right: -w * 0.01,
                          child: Container(
                            width: w * 0.045, height: w * 0.045,
                            decoration: BoxDecoration(color: AppColors.badgeColor, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5)),
                            alignment: Alignment.center,
                            child: Text('${cartController.totalItemCount}', style: TextStyle(color: Colors.white, fontSize: w * 0.022, fontWeight: FontWeight.w800)),
                          ),
                        ),
                    ],
                  )),
                ],
              ),
            ),

            SizedBox(height: h * 0.02),

            // Fix #1: Category chips — selectedCategory drives color correctly
            // Obx(() => SizedBox(
            //   height: h * 0.05,
            //   child: ListView.separated(
            //     scrollDirection: Axis.horizontal,
            //     padding: EdgeInsets.symmetric(horizontal: w * 0.05),
            //     itemCount: controller.categories.length,
            //     separatorBuilder: (_, __) => SizedBox(width: w * 0.025),
            //     itemBuilder: (context, index) {
            //       final cat = controller.categories[index];
            //       // Fix #1: Only the tapped category gets primaryColor
            //       final isSelected = controller.selectedCategory.value == cat;
            //       return GestureDetector(
            //         onTap: () => controller.filterByCategory(cat),
            //         child: AnimatedContainer(
            //           duration: const Duration(milliseconds: 200),
            //           padding: EdgeInsets.symmetric(horizontal: w * 0.045, vertical: h * 0.008),
            //           decoration: BoxDecoration(
            //             color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
            //             borderRadius: BorderRadius.circular(w * 0.06),
            //             boxShadow: [
            //               BoxShadow(
            //                 color: isSelected ? AppColors.primaryColor.withOpacity(0.35) : Colors.black.withOpacity(0.05),
            //                 blurRadius: isSelected ? 8 : 6,
            //                 offset: Offset(0, isSelected ? 4 : 2),
            //               ),
            //             ],
            //           ),
            //           child: Text(
            //             cat == 'all' ? 'All' : cat.split("'").first.trim().capitalizeFirst!,
            //             style: GoogleFonts.raleway(
            //               fontSize: w * 0.032,
            //               fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            //               color: isSelected ? Colors.white : AppColors.textSecondaryColor,
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // )),

             Obx(() {
              final cats = controller.categories;
              return SizedBox(
                height: h * 0.05,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                  itemCount: cats.length,
                  separatorBuilder: (_, __) => SizedBox(width: w * 0.025),
                  itemBuilder: (context, index) {
                    final cat = cats[index];
                       return Obx(() {
                      final isSelected =
                          controller.selectedCategory.value == cat;
                      return GestureDetector(
                        onTap: () => controller.filterByCategory(cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: w * 0.045,
                            vertical: h * 0.008,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(w * 0.06),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.35),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                          ),
                          child: Text(
                            cat == 'all'
                                ? 'All'
                                : cat
                                    .split("'")
                                    .first
                                    .trim()
                                    .capitalizeFirst!,
                            style: GoogleFonts.raleway(
                              fontSize: w * 0.032,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondaryColor,
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              );
            }),

            SizedBox(height: h * 0.02),

            Expanded(
              child: Obx(() {
                if (controller.loadState.value == ProductLoadState.loading) {
                  return GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.7,
                      crossAxisSpacing: w * 0.04, mainAxisSpacing: h * 0.02,
                    ),
                    itemCount: 6,
                    itemBuilder: (_, __) => const ShimmerProductCard(),
                  );
                }
                if (controller.loadState.value == ProductLoadState.error) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off_rounded, size: w * 0.18, color: AppColors.greyColor.withOpacity(0.5)),
                        SizedBox(height: h * 0.02),
                        Text('Something went wrong', style: GoogleFonts.raleway(fontSize: w * 0.045, fontWeight: FontWeight.w700, color: AppColors.textPrimaryColor)),
                        SizedBox(height: h * 0.01),
                        Text(controller.errorMessage.value, textAlign: TextAlign.center, style: GoogleFonts.raleway(fontSize: w * 0.035, color: AppColors.textSecondaryColor)),
                        SizedBox(height: h * 0.03),
                        ElevatedButton.icon(
                          onPressed: controller.fetchProducts,
                          icon: const Icon(Icons.refresh_rounded),
                          label: Text('Retry', style: GoogleFonts.raleway(fontWeight: FontWeight.w700)),
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(w * 0.06))),
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  color: AppColors.primaryColor,
                  onRefresh: controller.fetchProducts,
                  child: controller.filteredProducts.isEmpty
                      ? Center(child: Text('No products found', style: GoogleFonts.raleway(fontSize: w * 0.042, color: AppColors.textSecondaryColor)))
                      : GridView.builder(
                          padding: EdgeInsets.fromLTRB(w * 0.05, 0, w * 0.05, h * 0.02),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.7,
                            crossAxisSpacing: w * 0.04, mainAxisSpacing: h * 0.02,
                          ),
                          itemCount: controller.filteredProducts.length,
                          itemBuilder: (context, index) => ProductCard(product: controller.filteredProducts[index]),
                        ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}