import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:foody/utils/styles.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/controllers/order_controller.dart';

class DeliveryOptions extends StatelessWidget {
  final String title;
  final String value;
  final double amount;
  final bool isFree;
  const DeliveryOptions(
      {super.key,
      required this.title,
      required this.value,
      required this.amount,
      required this.isFree});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Row(
        children: [
          Radio(
            value: value,
            groupValue: orderController.orderType,
            onChanged: (value) => orderController.setDeliveryType(value!),
            activeColor: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: Dimensions.width10 / 2,
          ),
          Text(
            title,
            style: robotoRegular,
          ),
          SizedBox(
            width: Dimensions.width10 / 2,
          ),
          Text(
            (value == 'take away' || isFree) ? '(free)' : '\$ (${amount / 10})',
            style: robotoMedium,
          )
        ],
      );
    });
  }
}
