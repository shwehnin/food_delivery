import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:foody/utils/color.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/app_icon.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/base/custom_loader.dart';
import 'package:foody/base/custom_app_bar.dart';
import 'package:foody/routes/route_helper.dart';
import 'package:foody/widgets/account_widget.dart';
import 'package:foody/controllers/user_controller.dart';
import 'package:foody/controllers/cart_controller.dart';
import 'package:foody/controllers/auth_controller.dart';
import 'package:foody/controllers/location_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();
      print("User has logged in");
    }
    return Scaffold(
      appBar: const CustomAppBar(title: "Profile"),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (userController.isLoading
                ? Container(
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        // profile icon
                        AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height45 + Dimensions.height30,
                          size: Dimensions.height15 * 10,
                        ),
                        SizedBox(
                          height: Dimensions.height30,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // name
                              AccountWidget(
                                text: BigText(
                                    text: userController.accountModel!.name),
                                appIcon: AppIcon(
                                  icon: Icons.person,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              // phone
                              AccountWidget(
                                text: BigText(
                                    text: userController.accountModel!.phone),
                                appIcon: AppIcon(
                                  icon: Icons.phone,
                                  backgroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              // email
                              AccountWidget(
                                text: BigText(
                                    text: userController.accountModel!.email),
                                appIcon: AppIcon(
                                  icon: Icons.email,
                                  backgroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              // address
                              GetBuilder<LocationController>(
                                builder: (locationController) {
                                  if (_userLoggedIn &&
                                      locationController.addressList.isEmpty) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.offNamed(RouteHelper.getAddress());
                                      },
                                      child: AccountWidget(
                                        text: BigText(
                                            text: "Fill in your address"),
                                        appIcon: AppIcon(
                                          icon: Icons.location_on,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.offNamed(RouteHelper.getAddress());
                                      },
                                      child: AccountWidget(
                                        text: BigText(text: "Your Address"),
                                        appIcon: AppIcon(
                                          icon: Icons.location_on,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              // message
                              // AccountWidget(
                              //   text: BigText(text: "Hnin Hnin Wai"),
                              //   appIcon: AppIcon(
                              //     icon: Icons.message_outlined,
                              //     backgroundColor: Colors.redAccent,
                              //     iconColor: Colors.white,
                              //     iconSize: Dimensions.height10 * 5 / 2,
                              //     size: Dimensions.height10 * 5,
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: Dimensions.height20,
                              // ),
                              // message
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .userLoggedIn()) {
                                    Get.find<AuthController>()
                                        .clearSharedData();
                                    Get.find<CartController>().clear();
                                    Get.find<CartController>()
                                        .clearCartHistory();
                                    Get.find<LocationController>()
                                        .clearAddressList();
                                    Get.offNamed(RouteHelper.getSignIn());
                                  } else {
                                    Get.offNamed(RouteHelper.getSignIn());
                                  }
                                },
                                child: AccountWidget(
                                  text: BigText(text: "Logout"),
                                  appIcon: AppIcon(
                                    icon: Icons.logout,
                                    backgroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  )
                : const CustomLoader())
            : SizedBox(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height20 * 15,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/pp.png",
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getSignIn());
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 5,
                          margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            top: Dimensions.height20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: Center(
                              child: BigText(
                            text: "Sign In",
                            color: Colors.white,
                            size: Dimensions.font26,
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
