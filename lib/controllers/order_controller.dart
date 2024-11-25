import 'package:get/get.dart';
import 'package:foody/models/order_model.dart';
import 'package:foody/models/place_order_model.dart';
import 'package:foody/data/repository/order_repo.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;

  OrderController({
    required this.orderRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late List<OrderModel> _currentOrderList = [];
  List<OrderModel> get currentOrderList => _currentOrderList;
  late List<OrderModel> _historyOrderList = [];
  List<OrderModel> get runningOrderList => _historyOrderList;

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  String _orderType = "delivery";
  String get orderType => _orderType;

  String _foodNote = " ";
  String get foodNote => _foodNote;

  Future<void> placeOrder(PlaceOrderModel placeOrder, Function callback) async {
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrder);
    if (response.statusCode == 200) {
      _isLoading = false;
      String message = response.body["message"];
      String orderId = response.body["order_id"].toString();
      callback(true, message, orderId);
    } else {
      callback(false, response.statusText, '-1');
    }
  }

  Future<void> getOrderList() async {
    _isLoading = true;
    Response response = await orderRepo.getOrderList();
    if (response.statusCode == 200) {
      _historyOrderList = [];
      _currentOrderList = [];
      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == 'pending' ||
            orderModel.orderStatus == 'accepted' ||
            orderModel.orderStatus == 'processing' ||
            orderModel.orderStatus == 'handover' ||
            orderModel.orderStatus == 'picked_up') {
          _currentOrderList.add(orderModel);
        } else {
          _historyOrderList.add(orderModel);
        }
      });
    } else {
      _currentOrderList = [];
      _historyOrderList = [];
    }
    _isLoading = false;
    print(
        "The length of the current order list is ${_currentOrderList.length}");
    print(
        "The length of the history order list is ${_historyOrderList.length}");
    update();
  }

  void setPayment(int index) {
    _paymentIndex = index;
    update();
  }

  void setDeliveryType(String type) {
    _orderType = type;
    update();
  }

  void setFoodNote(String note) {
    _foodNote = note;
  }
}
