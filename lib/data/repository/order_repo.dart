import 'package:get/get.dart';
import 'package:foody/data/api/api_client.dart';
import 'package:foody/utils/app_constants.dart';
import 'package:foody/models/place_order_model.dart';

class OrderRepo {
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response> placeOrder(PlaceOrderModel placeOrder) async {
    return await apiClient.postData(
      AppConstants.PLACE_ORDER_URI,
      placeOrder.toJson(),
    );
  }

  Future<Response> getOrderList() async {
    return await apiClient.getData(AppConstants.ORDER_LIST_URI);
  }
}
