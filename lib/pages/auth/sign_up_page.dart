import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foody/utils/color.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:foody/models/user_model.dart';
import 'package:foody/base/custom_loader.dart';
import 'package:foody/routes/route_helper.dart';
import 'package:foody/widgets/app_text_field.dart';
import 'package:foody/base/show_custom_snackbar.dart';
import 'package:foody/controllers/auth_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    List<String> imgs = ["f.png", "g.png", "t.png"];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Name is required ", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Phone number is required ", title: "Phone Number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Email address is required ",
            title: "Email Address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address ",
            title: "Valid Email Address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Password is required ", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password cann't be less than 6 characters",
            title: "Password");
      } else {
        UserModel user = UserModel(
            name: name, phone: phone, email: email, password: password);
        authController.registration(user).then((status) {
          if (status.isSuccess) {
            print("Success Registration");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
        print("User Data $user");
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading
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
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // your email
                    AppTextField(
                      textController: emailController,
                      hintText: "Email",
                      icon: Icons.email,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    // your password
                    AppTextField(
                      suffixIcon:_authController.showPassword ? Icons.visibility : Icons.visibility_off,
                      isObscure: !_authController.showPassword,
                      textController: passwordController,
                      hintText: 'Password',
                      icon: Icons.password,
                      
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    // your name
                    AppTextField(
                      textController: nameController,
                      hintText: 'Name',
                      icon: Icons.person,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    // your phone
                    AppTextField(
                      textController: phoneController,
                      hintText: 'Phone',
                      icon: Icons.phone,
                    ),
                    SizedBox(
                      height: Dimensions.height20 + Dimensions.height20,
                    ),
                    // sign up button
                    GestureDetector(
                      onTap: () {
                        _registration(_authController);
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
                            text: "Sign Up",
                            size: Dimensions.font20 + Dimensions.font20 / 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "Have an account already?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * .05,
                    ),
                    // sign up options
                    RichText(
                      text: TextSpan(
                          text: "Sign up using one of the following methods",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16,
                          )),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Wrap(
                      spacing: Dimensions.width10,
                      children: List.generate(
                        3,
                        (index) => Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: Dimensions.radius30,
                            backgroundImage:
                                AssetImage("assets/images/${imgs[index]}"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }
}
