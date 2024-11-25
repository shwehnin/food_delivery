import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../models/order_model.dart';
import 'package:foody/utils/color.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/base/custom_loader.dart';
import 'package:foody/routes/route_helper.dart';
import 'package:foody/utils/app_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  final OrderModel orderModel;
  const PaymentPage({super.key, required this.orderModel});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late String selectedUrl;
  double value = 0.0;
  bool _canRedirect = true;
  bool _isLoading = true;
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    selectedUrl =
        "${AppConstants.BASE_URL}/payment-mobile?customer_id=${widget.orderModel.userId}&order_id=${widget.orderModel.id}";

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1')
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print("Web view loading progress $progress");
          },
          onPageStarted: (String url) {
            print("Page start loading $url");
            setState(() {
              _isLoading = true;
            });
            _redirectUrl(url);
          },
          onPageFinished: (String url) {
            print("Page finished loading $url");
            setState(() {
              _isLoading = false;
            });
            _redirectUrl(url);
          },
        ),
      )
      ..loadRequest(Uri.parse(selectedUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Payment"),
        leading: IconButton(
          // onPressed: () {},
          onPressed: () => _exitApp(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Center(
        child: Container(
          width: Dimensions.screenWidth,
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              // WebView(
              //   javascriptMode: JavascriptMode.unrestricted,
              //   initialUrl: selectedUrl,
              //   gestureNavigationEnabled: true,
              //   userAgent:
              //       'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
              //   onWebViewCreated: (WebViewController webViewController) {
              //     _controller.future.then((value) => controllerGlobal);
              //     _controller.complete(webViewController);
              //   },
              //   onProgress: (int progress) {
              //     print("Web view loading progress $progress");
              //   },
              //   onPageStarted: (String url) {
              //     print("Page start loading $url");
              //     setState(() {
              //       _isLoading = true;
              //     });
              //     print("Printing url $url");
              //     _redirectUrl(url);
              //   },
              //   onPageFinished: (String url) {
              //     print("Page finished loading $url");
              //     setState(() {
              //       _isLoading = false;
              //     });
              //     _redirectUrl(url);
              //   },
              // ),
              _isLoading
                  ? const Center(
                      child: CustomLoader(),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  void _redirectUrl(String url) {
    print("Redirecting to $url");
    if (_canRedirect) {
      bool _isSuccess =
          url.contains('success') && url.contains(AppConstants.APP_NAME);
      bool _isFailed =
          url.contains('fail') && url.contains(AppConstants.BASE_URL);
      bool _isCancel =
          url.contains('cancel') && url.contains(AppConstants.BASE_URL);
      if (_isSuccess || _isFailed || _isCancel) {
        _canRedirect = false;
      }
      if (_isSuccess) {
        Get.offNamed(RouteHelper.getOrderSuccess(
            widget.orderModel.id.toString(), "success"));
      } else if (_isFailed || _isCancel) {
        Get.offNamed(RouteHelper.getOrderSuccess(
            widget.orderModel.id.toString(), "fail"));
      } else {
        print("Uncountered problem");
      }
    }
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      print("App exited");
      return Future.value(true);
    }
  }

  // Future<bool> _exitApp(BuildContext context) async {
  //   if (await controllerGlobal.canGoBack()) {
  //     controllerGlobal.goBack();
  //     return Future.value(false);
  //   } else {
  //     print("app exited");
  //     return true;
  //   }
  // }

  // void _redirectUrl(String url) {
  //   print("Redirecting to $url");
  //   if (_canRedirect) {
  //     bool _isSuccess =
  //         url.contains('success') && url.contains(AppConstants.APP_NAME);
  //     bool _isFailed =
  //         url.contains('fail') && url.contains(AppConstants.BASE_URL);
  //     bool _isCancel =
  //         url.contains('cancel') && url.contains(AppConstants.BASE_URL);
  //     if (_isSuccess || _isFailed || _isCancel) {
  //       _canRedirect = false;
  //     }
  //     if (_isSuccess) {
  //       Get.offNamed(RouteHelper.getOrderSuccess(
  //           widget.orderModel.id.toString(), "success"));
  //     } else if (_isFailed || _isCancel) {
  //       Get.offNamed(RouteHelper.getOrderSuccess(
  //           widget.orderModel.id.toString(), "fail"));
  //     } else {
  //       print("Encountered a problem");
  //     }
  //   }
  // }
}
