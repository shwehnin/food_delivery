import 'package:flutter/material.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/widgets/big_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backBtn;
  final Function? onBackPressed;
  const CustomAppBar(
      {super.key,
      required this.title,
      this.backBtn = true,
      this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.mainColor,
      title: BigText(
        text: title,
        color: Colors.white,
      ),
      leading: backBtn
          ? IconButton(
              onPressed: () => onBackPressed != null
                  ? onBackPressed!()
                  : Navigator.pushReplacementNamed(context, "/initial"),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            )
          : const SizedBox(),
    );
  }

  @override
  Size get preferredSize => const Size(500, 55);
}
