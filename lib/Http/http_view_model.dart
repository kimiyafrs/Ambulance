import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shamsi_date/shamsi_date.dart';
import '../AppValues/app_values.dart';
import '../Model/ambulance_list_model.dart';
import '../Model/report_model.dart';
import '../Model/visit_model.dart';
import '../Model/model.dart';
import 'http_model.dart';

class HttpViewModel extends GetxController {
  late HttpModel _model;
  var ambulances = <AmbulanceListModel>[];
  var visits = <VisitModel>[];
  var filteredVisits = <VisitModel>[];
  var reports = <ReportModel>[];
  var isConnected = false.obs;

  HttpViewModel() {
    _model = HttpModel();
  }

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    sendGetTokenRequest();
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void clearVisits() {
    visits.clear();
    update();
  }

  Future<void> _initConnectivity() async {
    try {
      List<ConnectivityResult> result = await Connectivity().checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      print('Error checking connectivity: $e');
    }
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi)) {
      isConnected.value = true;
    } else {
      isConnected.value = false;
    }
    print('Connection status updated: $isConnected');
  }

  Future<void> setToken(String value) async {
    final storage = GetStorage();
    await storage.write('token', value);
  }

  Future<String?> getToken() async {
    final storage = GetStorage();
    return storage.read('token');
  }

  Future<void> sendGetTokenRequest() async {
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
        await setToken(_model.token);
        update();
      } else {
        print('Failed to get token: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to authenticate: $e');
    }
  }

  Future<void> getAmbulanceList() async {
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
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('ListAmbulance')) {
          List<dynamic> dataList = jsonResponse['ListAmbulance'];
          ambulances = dataList
              .map((item) => AmbulanceListModel.fromJson(item))
              .map((ambulance) {
            ambulance.code = ambulance.code ?? 'No code';
            return ambulance;
          }).where((ambulance) =>
          ambulance.code != null && ambulance.code!.isNotEmpty)
              .toList();

          update();
        } else {
          print('No ListAmbulance key in response');
        }
      } else {
        print('Failed to load ambulances: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to fetch ambulance list: $e');
    }
  }

  ///
  ///
  Future<void> getVisit() async {
    if (_model.postFile['DeviceCode'] == null || _model.postFile['DeviceCode'].isEmpty) {
      print('Error: DeviceCode is empty. Please set a valid DeviceCode.');
      return;
    }

    String url = '${AppValues.API_BASE_URL}GetFile';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'TimeReceived': _model.timeReceived ?? '0',
          'Token': _model.token,
          'DeviceCode': _model.code ?? '0'
        }),
      );
      print('Visits: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        VisitModel visitModel = VisitModel.fromJson(jsonResponse);


        visitModel.DeviceCode ??= '0';
        visitModel.TimeReceived ??= '0';
        visitModel.PatientNationalCode ??= '0';
        visitModel.Description ??= '';
        visitModel.Resp ??= 0;
        visitModel.Tg ??= '';
        visitModel.Ldl ??= '';
        visitModel.Hdl ??= '';
        visitModel.Glucose ??= '';
        visitModel.NibpSys ??= 0;
        visitModel.NibpDias ??= 0;
        visitModel.NibpMean ??= 0;
        visitModel.Spo2 ??= 0;
        visitModel.Hr ??= 0;
        visitModel.Pr ??= 0;
        visitModel.PatientName ??= '';
        visitModel.PatientGender ??= '';
        visitModel.T1 ??= 0;
        visitModel.T2 ??= 0;
        visitModel.Etco2 ??= 0;
        visitModel.Fico2 ??= 0;
        visitModel.Rr ??= 0;

        visits.add(visitModel);


        filteredVisits = visits.where((visit) => visit.TimeReceived == _model.timeReceived).toList();

        print('Visit added: ${visitModel}');
        update();
      } else if (response.statusCode == 204) {
        print('No visits available for this ambulance.');
      } else {
        print('Failed to load visit: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to fetch visit: $e');
    }
  }

  Future<void> getReport() async {
    String url = '${AppValues.API_BASE_URL}GetReport';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'Token': _model.token ?? '',
          'Ambcode': _model.code.trim() ?? '',
          'From': _model.from.millisecondsSinceEpoch ?? '',
          'To': _model.to.millisecondsSinceEpoch ?? '',
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        print('Report Response: $jsonResponse');
        if (jsonResponse.containsKey('ListReport')) {
          List<dynamic> dataList = jsonResponse['ListReport'];
          reports = dataList
              .map((item) => ReportModel.fromJson(item))
              .where((report) => report.Code != null && report.Code!.isNotEmpty)
              .toList();


          reports.forEach((report) {
            if (report.Time != null) {
              report.TimeJalali = convertToJalali(report.Time!);
            }
          });
          print('Reports loaded: ${reports.length}');
          update();
        } else {
          print('No ListReport key in response');
        }
      } else {
        print('Failed to load reports: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to fetch report list: $e');
    }
  }

  Future<void> setTime(int time) async {
    if (time != null) {
      _model.timeReceived = time;
      _model.postFile['TimeReceived'] = time;
      print('TimeReceived set to: $time');
      update();
    } else {
      print('Error: Invalid TimeReceived provided.');
    }
  }

  Future<void> setAmbCode(String code) async {
    if (code.isNotEmpty) {
      _model.code = code.trim();
      _model.postReport['Ambcode'] = _model.code;
      _model.postFile['DeviceCode'] = _model.code;
      print('Ambcode set to: ${_model.code}');
      update();
    } else {
      print('Error: Invalid DeviceCode provided.');
    }
  }

  String convertToJalali(int milliseconds) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    Jalali jalaliDate = Jalali.fromDateTime(dateTime);
    return '${jalaliDate.year}/${jalaliDate.month}/${jalaliDate.day}';
  }
}