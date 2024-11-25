import 'package:flutter/material.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/small_text.dart';

class IconTextWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  const IconTextWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize24,
        ),
        const SizedBox(
          width: 3,
        ),
        SmallText(
          text: text,
        )
      ],
    );
  }
}
