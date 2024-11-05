import 'package:get/get.dart';
import 'pick_address_map.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/base/custom_app_bar.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonNameController =
      TextEditingController();
  final TextEditingController _contactPersonNumberController =
      TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);

  late LatLng _initialPosition = const LatLng(45.51563, -122.677433);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().accountModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(
            Get.find<LocationController>().getAddress["latitude"],
          ),
          double.parse(
            Get.find<LocationController>().getAddress["longitude"],
          ),
        ),
      );
      _initialPosition = LatLng(
        double.parse(
          Get.find<LocationController>().getAddress["latitude"],
        ),
        double.parse(
          Get.find<LocationController>().getAddress["longitude"],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Address'),
      body: GetBuilder<UserController>(builder: (userController) {
        if (userController.accountModel != null &&
            _contactPersonNameController.text.isEmpty) {
          _contactPersonNameController.text = userController.accountModel!.name;
          _contactPersonNumberController.text =
              userController.accountModel!.phone;
          if (Get.find<LocationController>().addressList.isNotEmpty) {
            _addressController.text =
                Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController) {
          _addressController.text = '${locationController.placemark.name ?? ''}'
              '${locationController.placemark.locality ?? ''}'
              '${locationController.placemark.postalCode ?? ''}'
              '${locationController.placemark.country ?? ''}';
          print("Address in my view is ${_addressController.text}");
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // margin: EdgeInsets.only(
                  //   left: Dimensions.width20,
                  //   right: Dimensions.width20,
                  //   top: Dimensions.height20,
                  // ),
                  height: 140,
                  width: Dimensions.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: AppColors.mainColor),
                  ),
                  child: Stack(children: [
                    GoogleMap(
                      onTap: (latlng) {
                        Get.toNamed(
                          RouteHelper.getPickAddressMap(),
                          arguments: PickAddressMap(
                            fromAddress: true,
                            fromSignup: false,
                            googleMapController:
                                locationController.mapController,
                          ),
                        );
                      },
                      initialCameraPosition:
                          CameraPosition(target: _initialPosition, zoom: 17),
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: false,
                      myLocationEnabled: true,
                      onCameraIdle: () {
                        locationController.updatePosition(
                            _cameraPosition, true);
                      },
                      onCameraMove: ((position) => _cameraPosition = position),
                      onMapCreated: (GoogleMapController controller) {
                        locationController.setMapController(controller);
                      },
                    )
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    top: Dimensions.height20,
                  ),
                  child: SizedBox(
                    height: Dimensions.height10 * 5,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: locationController.addressTypeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              locationController.setAddressTypeIndex(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width20,
                                vertical: Dimensions.height10,
                              ),
                              margin:
                                  EdgeInsets.only(right: Dimensions.width20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radius20 / 4,
                                  ),
                                  color: Theme.of(context).cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[200]!,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    )
                                  ]),
                              child: Icon(
                                index == 0
                                    ? Icons.home_filled
                                    : index == 1
                                        ? Icons.work
                                        : Icons.location_on,
                                color:
                                    locationController.addressTypeIndex == index
                                        ? AppColors.mainColor
                                        : Theme.of(context).disabledColor,
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Delivery Address"),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                AppTextField(
                  textController: _addressController,
                  hintText: 'Your address',
                  icon: Icons.map,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact Name"),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                AppTextField(
                  textController: _contactPersonNameController,
                  hintText: 'Your name',
                  icon: Icons.person,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact Phone"),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                AppTextField(
                  textController: _contactPersonNumberController,
                  hintText: 'Your phone',
                  icon: Icons.phone,
                ),
              ],
            ),
          );
        });
      }),
      bottomNavigationBar:
          GetBuilder<LocationController>(builder: (locationController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20,
                  vertical: Dimensions.height30),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      AddressModel _addressModel = AddressModel(
                        addressType: locationController.addressTypeList[
                            locationController.addressTypeIndex],
                        contactPersonName: _contactPersonNameController.text,
                        contactPersonNumber: _contactPersonNameController.text,
                        address: _addressController.text,
                        latitude:
                            locationController.position.latitude.toString(),
                        longitude:
                            locationController.position.longitude.toString(),
                      );
                      locationController
                          .addAddress(_addressModel)
                          .then((response) {
                        if (response.isSuccess) {
                          Get.toNamed(RouteHelper.getInitial());
                          Get.snackbar("Address", "Address Successfully");
                        } else {
                          Get.snackbar("Address", "Address couldn't add");
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius20,
                        ),
                        color: AppColors.mainColor,
                      ),
                      child: BigText(
                        text: "Save Address",
                        color: Colors.white,
                        size: Dimensions.font26,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
