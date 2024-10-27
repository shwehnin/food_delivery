import 'big_text.dart';
import 'small_text.dart';
import '../utils/color.dart';
import 'icon_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: 15,
                );
              }),
            ),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: '4.5'),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: '1287'),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: 'comments')
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconTextWidget(
              text: 'Normal',
              icon: Icons.circle_sharp,
              iconColor: AppColors.iconColor1,
            ),
            IconTextWidget(
              text: '1.7km',
              icon: Icons.location_on,
              iconColor: AppColors.mainColor,
            ),
            IconTextWidget(
              text: '32min',
              icon: Icons.access_time_rounded,
              iconColor: AppColors.iconColor2,
            ),
          ],
        ),
      ],
    );
  }
}
