import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foody/utils/color.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/base/custom_loader.dart';
import 'package:foody/routes/route_helper.dart';
import 'package:foody/widgets/app_text_field.dart';
import 'package:foody/pages/auth/sign_up_page.dart';
import 'package:foody/base/show_custom_snackbar.dart';
import 'package:foody/controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      if (phone.isEmpty) {
        showCustomSnackBar("Name is required", title: "Name");
      } else if (password.isEmpty) {
        showCustomSnackBar("Password is required", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password cann't be less than 6 characters",
            title: "Password");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getCart());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * .05,
                    ),
                    // app logo
                    // Container(
                    //   height: Dimensions.screenHeight * 0.25,
                    //   child: const Center(
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.white,
                    //       radius: 80,
                    //       backgroundImage:
                    //           AssetImage('assets/images/fish.jpeg'),
                    //     ),
                    //   ),
                    // ),
                    Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: Lottie.asset("assets/json/login.json")),
                    // welcome
                    Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, top: Dimensions.height20),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello",
                            style: TextStyle(
                              fontSize:
                                  Dimensions.font20 * 3 + Dimensions.font20 / 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // tag line
                          Text(
                            "Signin to your account",
                            style: TextStyle(
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    // your phone
                    AppTextField(
                      keyboardType: TextInputType.phone,
                      textController: phoneController,
                      hintText: 'Phone',
                      icon: Icons.phone,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),

                    // your password
                    AppTextField(
                      isObscure: authController.showPassword,
                      textController: passwordController,
                      hintText: 'Password',
                      icon: Icons.password,
                      suffixIcon: authController.showPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),

                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        RichText(
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back(),
                            text: "Signin your account ",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width20,
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * .05,
                    ),
                    // sign in button
                    GestureDetector(
                      onTap: () {
                        _login(authController);
                      },
                      child: Container(
                        width: Dimensions.screenWidth / 2,
                        height: Dimensions.screenHeight / 13,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          color: AppColors.mainColor,
                        ),
                        child: Center(
                          child: BigText(
                            text: "Sign In",
                            size: Dimensions.font20 + Dimensions.font20 / 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * .05,
                    ),

                    // sign up options
                    RichText(
                      text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                // ..onTap = () => Get.toNamed(RouteHelper.getSignUp()),
                                ..onTap = () => Get.to(() => const SignUpPage(),
                                    transition: Transition.fadeIn),
                              text: "Create",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainBlackColor,
                                fontSize: Dimensions.font20,
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }
}
