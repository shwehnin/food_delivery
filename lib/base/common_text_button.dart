import '../utils/color.dart';
import '../utils/dimensions.dart';
import '../widgets/big_text.dart';
import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  const CommonTextButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Dimensions.height20,
        bottom: Dimensions.height20,
        left: Dimensions.width20,
        right: Dimensions.width20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Dimensions.radius20,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            blurRadius: 10,
            color: AppColors.mainColor.withOpacity(.3),
          ),
        ],
        color: AppColors.mainColor,
      ),
      child: Center(
        child: BigText(
          text: text,
          color: Colors.white,
        ),
      ),
    );
  }
}
