// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'package:untitled2/Request_model/request_model.dart';
//
//
// class AmbulanceViewModel extends GetxController {
//
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   Future<void> fetchUsers() async {
//     final response = await http.get(Uri.parse('https://46.249.102.43/api/chronos/GetAllDevices'));
//     if (response.statusCode == 200) {
//       List<dynamic> jsonList = json.decode(response.body);
//       ambulances = jsonList.map((json) => RequestModel.fromJson(json)).toList();
//       update();
//     }
//   }
// }
//
