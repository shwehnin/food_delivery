import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:food_delivery/data/api/api_checker.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:food_delivery/data/repository/location_repo.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  bool _loading = false;
  bool get loading => _loading;

  late Position _position;
  Position get position => _position;

  late Position _pickPosition;
  Position get pickPosition => _pickPosition;

  Placemark _placemark = Placemark();
  Placemark get placemark => _placemark;

  Placemark _pickPlacemark = Placemark();
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;

  late List<AddressModel> _allAddressList = [];
  List<AddressModel> get allAddressList => _allAddressList;

  List<String> _addressTypeList = ["Home", "Work", "Other"];
  List<String> get addressTypeList => _addressTypeList;

  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _inZone = false;
  bool get inZone => _inZone;

  bool _buttonDisable = true;
  bool get buttonDisable => _buttonDisable;

  List<dynamic> _predictionList = [];

  Future<void> getCurrentLocation(bool fromAddress,
      {required GoogleMapController mapController,
      LatLng? defaultLatLng,
      bool notify = true}) async {
    _loading = true;
    if (notify) {
      update();
    }
    AddressModel _addressModel;
    late Position _myPosition;
    Position _test;
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      _myPosition = position;
      if (fromAddress) {
        _position = _myPosition;
      } else {
        _pickPosition = _myPosition;
      }
    });
  }

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            altitudeAccuracy: 1,
            heading: 1,
            headingAccuracy: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        } else {
          _pickPosition = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            altitudeAccuracy: 1,
            heading: 1,
            headingAccuracy: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        }
        ResponseModel _responseModel = await getZone(
            position.target.latitude.toString(),
            position.target.longitude.toString(),
            false);
        _buttonDisable = !_responseModel.isSuccess;
        if (_changeAddress) {
          String _address = await getAddressFromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        } else {
          _changeAddress = true;
        }
      } catch (e) {
        throw e;
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = "Unknown location found";
    Response response = await locationRepo.getAddressFromGeocode(latLng);
    if (response.body["status"] == "OK") {
      _address = response.body["results"][0]["formatted_address"].toString();
      print("Printing address $_address");
    } else {
      print("Error getting the google api");
    }
    update();
    return _address;
  }

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      print("couldn't save the address");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();
    Response response = await locationRepo.getZone(lat, lng);
    if (response.statusCode == 200) {
      _inZone = true;
      _responseModel = ResponseModel(true, response.body["zone_id"].toString());
      // if (response.body["zone_id"] != 2) {
      //   _responseModel =
      //       ResponseModel(false, response.body["zone_id"].toString());
      //   _inZone = false;
      // } else {
      //   _responseModel =
      //       ResponseModel(true, response.body["zone_id"].toString());
      //   _inZone = true;
      // }
    } else {
      _inZone = false;
      _responseModel = ResponseModel(false, response.statusText!);
    }
    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    update();
    return _responseModel;
  }

  // Future<List<dynamic>> searchLocation(
  //     BuildContext context, String text) async {
  //   if (text.isNotEmpty) {
  //     Response response = await locationRepo.searchLocation(text);
  //     if (response.statusCode == 200 && response.body["status"] == "OK") {
  //       _predictionList = [];
  //       response.body["predictions"].forEach(
  //         (prediction) => _predictionList.add(Prediction.fromJson(prediction)),
  //       );
  //     } else {
  //       ApiChecker.checkApi(response);
  //     }
  //   }
  //   return _predictionList;
  // }

  // setLocation(
  //     String placeId, String address, GoogleMapController mapController) async {
  //   _loading = true;
  //   update();
  //   PlacesDetailsResponse detail;
  //   Response response = await locationRepo.setLocation(placeId);
  //   detail = PlacesDetailsResponse.fromJson(response.body);
  //   _pickPosition = Position(
  //     longitude: detail.result.geometry!.location.lng,
  //     latitude: detail.result.geometry!.location.lat,
  //     timestamp: DateTime.now(),
  //     accuracy: 1,
  //     altitude: 1,
  //     altitudeAccuracy: 1,
  //     heading: 1,
  //     headingAccuracy: 1,
  //     speed: 1,
  //     speedAccuracy: 1,
  //   );
  //   _pickPlacemark = Placemark(name: address);
  //   _changeAddress = false;
  //   if (!mapController.isNull) {
  //     mapController.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //         target: LatLng(
  //           detail.result.geometry!.location.lat,
  //           detail.result.geometry!.location.lng,
  //         ),
  //         zoom: 17,
  //       ),
  //     ));
  //   }
  //   _loading = false;
  //   update();
  // }
}
