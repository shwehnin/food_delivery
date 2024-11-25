import 'package:get/get.dart';
import 'package:foody/routes/route_helper.dart';
import 'package:foody/base/show_custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.offNamed(RouteHelper.getSignIn());
    } else {
      showCustomSnackBar(response.statusText!);
    }
  }
}
