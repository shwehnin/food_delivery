import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'pages/splash/splash_page.dart';
import 'helper/dependencies.dart' as dep;
import 'controllers/cart_controller.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          // home: const SignInPage(),
          initialRoute: RouteHelper.getSplash(),
          getPages: RouteHelper.routes,
          theme:
              ThemeData(primaryColor: AppColors.mainColor, fontFamily: "Lato"),
        );
      });
    });
  }
}
