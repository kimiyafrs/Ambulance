import 'package:flutter/cupertino.dart';

class AppValues {
  static String API_BASE_URL = 'https://46.249.102.43/api/chronos/';
  static double getWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double getHight(BuildContext context) => MediaQuery.of(context).size.height;


  static void updateBaseUrl(String newUrl) {
    API_BASE_URL = newUrl;
  }
}