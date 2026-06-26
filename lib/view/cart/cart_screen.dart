import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../constants/app_colors.dart';
import '../../controllers/cart_controller.dart';
import '../../components/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
              padding: EdgeInsets.fromLTRB(
                  w * 0.05, h * 0.025, w * 0.05, 0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Cart',
                        style: GoogleFonts.raleway(
                          fontSize: w * 0.07,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimaryColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Obx(() => Text(
                            '${cartController.totalItemCount} items',
                            style: GoogleFonts.raleway(
                              fontSize: w * 0.034,
                              color: AppColors.textSecondaryColor,
                            ),
                          )),
                    ],
                  ),
                  const Spacer(),
                  Obx(() => cartController.cartItems.isNotEmpty
                      ? TextButton.icon(
                          onPressed: () {
                            Get.dialog(AlertDialog(
                              title: Text('Clear Cart',
                                  style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.w700)),
                              content: Text(
                                  'Remove all items from cart?',
                                  style: GoogleFonts.raleway()),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text('Cancel',
                                      style: GoogleFonts.raleway(
                                          color:
                                              AppColors.textSecondaryColor)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cartController.clearCart();
                                    Get.back();
                                  },
                                  child: Text('Clear',
                                      style: GoogleFonts.raleway(
                                          color: AppColors.errorColor,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ));
                          },
                          icon: Icon(Icons.delete_outline_rounded,
                              color: AppColors.errorColor,
                              size: w * 0.045),
                          label: Text('Clear',
                              style: GoogleFonts.raleway(
                                fontSize: w * 0.032,
                                color: AppColors.errorColor,
                                fontWeight: FontWeight.w600,
                              )),
                        )
                      : const SizedBox()),
                ],
              ),
            ),

            SizedBox(height: h * 0.02),

          
            Expanded(
              child: Obx(() {
                if (cartController.cartItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: w * 0.25,
                          color:
                              AppColors.greyColor.withOpacity(0.4),
                        ),
                        SizedBox(height: h * 0.025),
                        Text(
                          'Your cart is empty',
                          style: GoogleFonts.raleway(
                            fontSize: w * 0.05,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimaryColor,
                          ),
                        ),
                        SizedBox(height: h * 0.01),
                        Text(
                          'Add items from the home screen',
                          style: GoogleFonts.raleway(
                            fontSize: w * 0.036,
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                  itemCount: cartController.cartItems.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: h * 0.015),
                  itemBuilder: (context, index) {
                    final item = cartController.cartItems[index];
                    return _CartItemCard(
                      index: index,
                      cartController: cartController,
                    );
                  },
                );
              }),
            ),

            Obx(() => cartController.cartItems.isEmpty
                ? const SizedBox()
                : Container(
                    padding: EdgeInsets.fromLTRB(
                      w * 0.06,
                      h * 0.02,
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(w * 0.06),
                        topRight: Radius.circular(w * 0.06),
                      ),
                    ),
                    child: Column(
                      children: [
                      
                        _SummaryRow(
                          label: 'Subtotal',
                          value:
                              '\$${cartController.totalPrice.toStringAsFixed(2)}',
                        ),
                        SizedBox(height: h * 0.008),
                        _SummaryRow(
                          label: 'Shipping',
                          value: 'FREE',
                          valueColor: AppColors.successColor,
                        ),
                        SizedBox(height: h * 0.01),
                        Divider(
                            color: AppColors.dividerColor,
                            thickness: 1),
                        SizedBox(height: h * 0.01),
                        Row(
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.raleway(
                                fontSize: w * 0.048,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimaryColor,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '\$${cartController.totalPrice.toStringAsFixed(2)}',
                              style: GoogleFonts.raleway(
                                fontSize: w * 0.055,
                                fontWeight: FontWeight.w900,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h * 0.02),
                        CustomButton(
                          title: 'Checkout',
                          onTap: () {
                            Get.snackbar(
                              '🎉 Order Placed!',
                              'Thank you for your purchase!',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: AppColors.successColor,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(12),
                              borderRadius: 12,
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: w * 0.05,
                          ),
                        ),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final int index;
  final CartController cartController;

  const _CartItemCard({
    required this.index,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Obx(() {
      if (index >= cartController.cartItems.length) {
        return const SizedBox();
      }
      final item = cartController.cartItems[index];

      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * 0.04),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(w * 0.04),
          child: Row(
            children: [
          
              ClipRRect(
                borderRadius: BorderRadius.circular(w * 0.03),
                child: Container(
                  width: w * 0.22,
                  height: w * 0.22,
                  color: AppColors.lightGreyColor,
                  child: CachedNetworkImage(
                    imageUrl: item.product.image,
                    fit: BoxFit.contain,
                    placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: w * 0.04),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.raleway(
                        fontSize: w * 0.034,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: h * 0.008),
                    Text(
                      '\$${item.product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.raleway(
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: h * 0.012),

                    Row(
                      children: [
                    
                        GestureDetector(
                          onTap: () =>
                              cartController.removeFromCart(item.product.id),
                          child: Container(
                            padding: EdgeInsets.all(w * 0.015),
                            decoration: BoxDecoration(
                              color: AppColors.errorColor.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(w * 0.02),
                            ),
                            child: Icon(
                              Icons.delete_outline_rounded,
                              color: AppColors.errorColor,
                              size: w * 0.04,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            _QtyBtn(
                              icon: Icons.remove,
                              onTap: () => cartController
                                  .decreaseQuantity(item.product.id),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.04),
                              child: Text(
                                '${item.quantity}',
                                style: GoogleFonts.raleway(
                                  fontSize: w * 0.042,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimaryColor,
                                ),
                              ),
                            ),
                            _QtyBtn(
                              icon: Icons.add,
                              onTap: () => cartController
                                  .increaseQuantity(item.product.id),
                              isPrimary: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _QtyBtn({
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w * 0.08,
        height: w * 0.08,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primaryColor : AppColors.lightGreyColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isPrimary ? Colors.white : AppColors.textPrimaryColor,
          size: w * 0.04,
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.raleway(
            fontSize: w * 0.036,
            color: AppColors.textSecondaryColor,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.raleway(
            fontSize: w * 0.038,
            fontWeight: FontWeight.w700,
            color: valueColor ?? AppColors.textPrimaryColor,
          ),
        ),
      ],
    );
  }
}