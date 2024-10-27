import 'package:get/get.dart';
import 'package:food_delivery/models/account_model.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:food_delivery/data/repository/user_repo.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late AccountModel _accountModel;
  AccountModel get accountModel => _accountModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _accountModel = AccountModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "Successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}
