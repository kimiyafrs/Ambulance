import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled2/AppValues/app_values.dart';
import 'package:untitled2/Http/http_model.dart';
import 'package:http/http.dart' as http;
import '../Model/ambulance_list_model.dart';
import '../Model/model.dart';
import '../Model/ambulance_model.dart';

class HttpViewModel extends GetxController {
  late HttpModel _model;
  late GetTokenModel _dataModel; //+
  var ambulances = <AmbulanceListModel>[].obs;

  HttpViewModel() {
    _model = HttpModel();
  }

  @override
  void onInit() {
    super.onInit();
    sendGetTokenRequest();
  }

  Future<void> setToken(String value) async {
    final storage = GetStorage();
    storage.write('token', value);
  }

  Future<String?> getToken() async {
    final storage = GetStorage();
    return storage.read('token');
  }

  Future<GetTokenModel?> sendGetTokenRequest() async {
    String url = '${AppValues.API_BASE_URL}GetToken';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(_model.postBody),
      );

      if (response.statusCode == 200) {
        GetTokenModel tokenModel = GetTokenModel.fromJson(json.decode(response.body));
        _model.token = tokenModel.data.toString();
        return tokenModel;
      }
    } catch (e) {
      throw Exception('Failed to authenticate');
    }
    return null;
  }

  Future<List<AmbulanceListModel>?> getAmbulanceList() async {
    String url = '${AppValues.API_BASE_URL}GetAllDevices';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(_model.postDevices),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        List<AmbulanceListModel> ambulanceListModel = jsonResponse.map((item) => AmbulanceListModel.fromJson(item)).toList();

        ambulances.value = ambulanceListModel; // ذخیره کردن داده‌های دریافت شده در `ambulances`

        return ambulanceListModel;
      }
    } catch (e) {
      throw Exception('Failed to fetch ambulance list: $e');
    }
    return null;
  }

  String? getDataFromModel() {
    return _dataModel.data;
  }
}


