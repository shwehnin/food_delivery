import 'package:get/get.dart';
import 'package:foody/models/order_model.dart';
import '../pages/address/pick_address_map.dart';
import 'package:foody/pages/home/home_page.dart';
import 'package:foody/pages/cart/cart_page.dart';
import 'package:foody/pages/auth/sign_up_page.dart';
import 'package:foody/pages/auth/sign_in_page.dart';
import 'package:foody/pages/splash/splash_page.dart';
import 'package:foody/pages/payment/payment_page.dart';
import 'package:foody/pages/address/add_address_page.dart';
import 'package:foody/pages/food/popular_food_detail.dart';
import 'package:foody/pages/payment/order_success_page.dart';
import 'package:foody/pages/food/recommended_food_detail.dart';

class RouteHelper {
  static const String splash = '/splash';
  static const String initial = '/';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cart = '/cart';
  static const String addAddress = '/add-address';
  static const String pickAddressMap = '/pick-address-map';
  static const String payment = '/payment';
  static const String orderSuccess = '/order-successful';

  static String getSplash() => splash;
  static String getInitial() => initial;
  static String getSignIn() => signin;
  static String getSignUp() => signup;
  static String getPopularFood(int pageId, String page) =>
      "$popularFood?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId, String page) =>
      "$recommendedFood?pageId=$pageId&page=$page";
  static String getCart() => cart;
  static String getAddress() => addAddress;
  static String getPickAddressMap() => pickAddressMap;
  static String getPayment(String id, int userId) =>
      "$payment?id=$id&userID=$userId";
  static String getOrderSuccess(String orderId, String status) =>
      "$orderSuccess?id=$orderId&status=$status";

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: signin, page: () => const SignInPage()),
    GetPage(name: signup, page: () => const SignUpPage()),
    GetPage(
        name: initial,
        page: () => const HomePage(),
        transition: Transition.fade),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(
            pageId: int.parse(pageId!),
            page: page!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetail(
            pageId: int.parse(pageId!),
            page: page!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cart,
        page: () => const CartPage(),
        transition: Transition.fadeIn),
    GetPage(name: addAddress, page: () => const AddAddressPage()),
    GetPage(
        name: pickAddressMap,
        page: () {
          PickAddressMap _pickAddressMap = Get.arguments;
          return _pickAddressMap;
        }),
    GetPage(
      name: payment,
      page: () => PaymentPage(
        orderModel: OrderModel(
          id: int.parse(Get.parameters['id']!),
          userId: int.parse(Get.parameters["userID"]!),
        ),
      ),
    ),
    GetPage(
        name: orderSuccess,
        page: () => OrderSuccessPage(
              orderId: Get.parameters["id"].toString(),
              status: Get.parameters["status"].toString().contains("success")
                  ? 1
                  : 0,
            ))
  ];
}
