// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

class GetTokenModel {
  int? _time;
  bool? _hasError;
  int? _errorCode;
  String? _data;
  String? _errorMessage;

  GetTokenModel({
    int? time,
    bool? hasError,
    int? errorCode,
    String? data,
    String? errorMessage,
  }) {
    _time = time;
    _hasError = hasError;
    _errorCode = errorCode;
    _data = data;
    _errorMessage = errorMessage;
  }

  String? get data => _data;
  set data(String? value) => _data = value;

  int? get time => _time;
  set time(int? value) => _time = value;

  bool? get hasError => _hasError;
  set hasError(bool? value) => _hasError = value;

  int? get errorCode => _errorCode;
  set errorCode(int? value) => _errorCode = value;

  String? get errorMessage => _errorMessage;
  set errorMessage(String? value) => _errorMessage = value;

  factory GetTokenModel.fromJson(Map<String, dynamic> json) {
    return GetTokenModel(
      time: json['Time'],
      hasError: json['HasError'],
      errorCode: json['ErrorCode'],
      data: json['Data'],
      errorMessage: json['ErrorMessage'],
    );
  }
}

