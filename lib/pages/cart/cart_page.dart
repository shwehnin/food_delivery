import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/utils/styles.dart';
import '../../controllers/location_controller.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/base/common_text_button.dart';
import 'package:food_delivery/models/place_order_model.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/pages/payment/delivery_options.dart';
import 'package:food_delivery/pages/payment/payment_option_button.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios_new,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(
            builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height15),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                              builder: (cartController) {
                            var _cartList = cartController.getItems;
                            return ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 100,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product!);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                RouteHelper.getPopularFood(
                                                    popularIndex, "cartpage"),
                                              );
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar(
                                                  "History Product",
                                                  "Product review is not available for history products",
                                                  backgroundColor:
                                                      AppColors.mainColor,
                                                  colorText: Colors.white,
                                                );
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getRecommendedFood(
                                                  recommendedIndex,
                                                  'cartpage',
                                                ));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.height20 * 5,
                                            height: Dimensions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}/${_cartList[index].img}",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimensions.width10,
                                        ),
                                        Expanded(
                                            child: Container(
                                          height: Dimensions.height20 * 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(
                                                text: _cartList[index].name!,
                                                color: Colors.black54,
                                              ),
                                              SmallText(text: "Spicy"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text:
                                                        "\$ ${_cartList[index].price}",
                                                    color: Colors.redAccent,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: Dimensions.height10,
                                                      bottom:
                                                          Dimensions.height10,
                                                      left: Dimensions.width10,
                                                      right: Dimensions.width10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radius20),
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        BigText(
                                                            text: _cartList[
                                                                    index]
                                                                .quantity
                                                                .toString()),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  );
                                });
                          }),
                        ),
                      ),
                    )
                  : const NoDataPage(text: "Your cart is empty!");
            },
          )
        ],
      ),
      bottomNavigationBar:
          GetBuilder<OrderController>(builder: (orderController) {
        _noteController.text = orderController.foodNote;
        return GetBuilder<CartController>(
          builder: (cartController) => Container(
            height: Dimensions.bottomHeightBar * 1.4,
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width20, vertical: Dimensions.height10),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: cartController.getItems.length > 0
                ? Column(
                    children: [
                      InkWell(
                        onTap: () => showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (_) {
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .9,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    Dimensions.radius20),
                                                topRight: Radius.circular(
                                                    Dimensions.radius20),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 520,
                                                  padding: EdgeInsets.only(
                                                    left: Dimensions.width20,
                                                    right: Dimensions.width20,
                                                    top: Dimensions.height20,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const PaymentOptionButton(
                                                          icon: Icons.money,
                                                          title:
                                                              'cash on delivery',
                                                          subTitle:
                                                              'you pay after getting the delivery',
                                                          index: 0),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .height10),
                                                      const PaymentOptionButton(
                                                          icon: Icons
                                                              .paypal_outlined,
                                                          title:
                                                              'digital payment',
                                                          subTitle:
                                                              'safer and faster way of payment',
                                                          index: 1),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .height30),
                                                      Text(
                                                        "Delivery Options",
                                                        style: robotoMedium,
                                                      ),
                                                      SizedBox(
                                                          height: Dimensions
                                                                  .height10 /
                                                              2),
                                                      DeliveryOptions(
                                                          title:
                                                              "home delivery",
                                                          value: "delivery",
                                                          amount: double.parse(
                                                              Get.find<
                                                                      CartController>()
                                                                  .totalAmount
                                                                  .toString()),
                                                          isFree: false),
                                                      SizedBox(
                                                          height: Dimensions
                                                                  .height10 /
                                                              2),
                                                      const DeliveryOptions(
                                                          title: "take away",
                                                          value: "take away",
                                                          amount: 10,
                                                          isFree: true),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .height20),
                                                      Text(
                                                        'Additional Notes',
                                                        style: robotoMedium,
                                                      ),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .height10),
                                                      AppTextField(
                                                          maxLines: true,
                                                          textController:
                                                              _noteController,
                                                          hintText: '',
                                                          icon: Icons.note)
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                            .whenComplete(() => orderController
                                .setFoodNote(_noteController.text.trim())),
                        child: const SizedBox(
                          width: double.maxFinite,
                          child: CommonTextButton(text: "Payment Options"),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: Dimensions.height20,
                              bottom: Dimensions.height20,
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Dimensions.width10 / 2,
                                ),
                                BigText(
                                    text: "\$ ${cartController.totalAmount}"),
                                SizedBox(
                                  width: Dimensions.width10 / 2,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (Get.find<AuthController>().userLoggedIn()) {
                                Get.find<AuthController>().updateToken();
                                // cartController.addToHistory();
                                if (Get.find<LocationController>()
                                    .addressList
                                    .isEmpty) {
                                  Get.toNamed(RouteHelper.getAddress());
                                } else {
                                  var location = Get.find<LocationController>()
                                      .getUserAddress();
                                  var cart =
                                      Get.find<CartController>().getItems;
                                  var user =
                                      Get.find<UserController>().accountModel;
                                  PlaceOrderModel placeOrder = PlaceOrderModel(
                                    cart: cart,
                                    orderAmount: 100,
                                    distance: 10.0,
                                    scheduleAt: '',
                                    orderNote: orderController.foodNote,
                                    address: location.address,
                                    latitude: location.latitude,
                                    longitude: location.longitude,
                                    contactPersonName: user!.name,
                                    contactPersonNumber: user.phone,
                                    orderType: orderController.orderType,
                                    paymentMethod:
                                        orderController.paymentIndex == 0
                                            ? "cash_on_delivery"
                                            : "digital_payment",
                                  );
                                  print(placeOrder.toJson());
                                  print(
                                      "My type is ${placeOrder.toJson()['order_type']}");
                                  print(
                                      "My payment method is ${placeOrder.toJson()['payment_method']}");
                                  // return;
                                  Get.find<OrderController>()
                                      .placeOrder(placeOrder, _callBack);
                                }
                              } else {
                                Get.toNamed(RouteHelper.getSignIn());
                              }

                              // popularProduct.addItem(product);
                            },
                            child: const CommonTextButton(text: "Checkout"),
                          )
                        ],
                      ),
                    ],
                  )
                : Container(),
          ),
        );
      }),
    );
  }

  void _callBack(bool isSuccess, String message, String orderId) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharePreference();
      Get.find<CartController>().addToHistory();
      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccess(orderId, "success"));
      } else {
        Get.offNamed(RouteHelper.getPayment(
            orderId, Get.find<UserController>().accountModel!.id));
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}
