import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/base/custom_app_bar.dart';
import 'package:food_delivery/pages/order/view_order.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/order_controller.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "My Orders",
      ),
      body: Column(
        children: [
          Container(
            width: Dimensions.screenWidth,
            child: TabBar(
                indicatorWeight: 3,
                dividerColor: Colors.transparent,
                indicatorColor: AppColors.mainColor,
                labelColor: AppColors.mainColor,
                unselectedLabelColor: AppColors.yellowColor,
                controller: _tabController,
                tabs: [
                  Tab(
                    text: "Current",
                  ),
                  Tab(
                    text: "Running",
                  ),
                ]),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              ViewOrder(isCurrent: true),
              ViewOrder(isCurrent: false),
            ]),
          )
        ],
      ),
    );
  }
}
