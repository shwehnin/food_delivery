class AppConstants {
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;
  static const String BASE_URL =
      "http://192.168.1.41:8000"; // https://dbf.dbestech.com
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String UPLOAD_URL = "/uploads";

  static const String TOKEN = "";
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String GEOCODE_URI = "/api/v1/config/geocode-api";
  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI = "/api/v1/customer/address/list";
  static const String ZONE_URI = "/api/v1/config/get-zone-id";
  static const String SEARCH_LOCATION_URI =
      "/api/v1/config/place-api-autocomplete";
  static const String PLACE_DETAILS_URI = "/api/v1/config/place-api-details";

  // user and auth end points
  static const String REGISTER_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO = "/api/v1/customer/info";
}