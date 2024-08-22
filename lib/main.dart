import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled2/Bidings/app_bidings.dart';
import 'package:untitled2/Screens/ambulance_list_screen.dart';
import 'package:untitled2/Model/ambulance_model.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
//main
void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/ambulance_screen',
      initialBinding: AppBindings(),
      getPages: [
        GetPage(name: '/ambulance_screen', page: ()=> AmbulanceListScreen()),
      ],
    );
  }
}

