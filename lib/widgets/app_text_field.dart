import '../utils/color.dart';
import 'package:get/get.dart';
import '../utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:foody/controllers/auth_controller.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final IconData? suffixIcon;
  bool isObscure;
  bool maxLines;
  TextInputType keyboardType;
  AppTextField({
    super.key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
    this.maxLines = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 7,
              offset: const Offset(1, 10),
              color: Colors.grey.withOpacity(.2),
            )
          ]),
      child: TextField(
        maxLines: maxLines ? null : 1,
        obscureText: isObscure ? true : false,
        controller: textController,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: AppColors.yellowColor,
          ),
          suffixIcon: GetBuilder<AuthController>(
            builder: (controller) => GestureDetector(
              onTap: () {
                controller.toggleShowPassword();
              },
              child: Icon(
                suffixIcon,
                color: AppColors.yellowColor,
              ),
            ),
          ),
          // focused border
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: const BorderSide(width: 1, color: Colors.white),
          ),
          // enabled border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: const BorderSide(width: 1, color: Colors.white),
          ),
          // border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
        ),
      ),
    );
  }
}
