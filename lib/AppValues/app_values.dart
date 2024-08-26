import 'package:flutter/cupertino.dart';

class AppValues {
  static const String API_BASE_URL = 'https://46.249.102.43/api/chronos/';
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double getHight(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
