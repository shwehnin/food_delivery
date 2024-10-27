import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  final BigText text;
  final AppIcon appIcon;
  const AccountWidget({
    super.key,
    required this.text,
    required this.appIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(.2),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        top: Dimensions.height20,
        bottom: Dimensions.height10,
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(
            width: Dimensions.width20,
          ),
          text,
        ],
      ),
    );
  }
}
