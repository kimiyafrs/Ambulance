import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class VisitModel {
  String? _deviceCode;
  String? _timeReceived;
  String? _patientName;
  int? _patientAge;
  String? _patientGender;
  String? _patientNationalCode;
  String? _description;
  List? _signals;
  int? _pcg;
  int? _paces;
  int? _masterLead;
  String? _notchFilter;
  String? _ecgFilter;
  int? _wires;
  int? _leadCount;
  int? _pdrReportAdrress;
  String? _tg;
  String? _ldl;
  String? _hdl;
  String? _glucose;
  int? _hr;
  int? _resp;
  int? _spo2;
  int? _pr;
  int? _nibpSys;
  int? _nibpDias;
  int? _nibpMean;
  int? _t1;
  int? _t2;
  int? _etco2;
  int? _fico2;
  int? _Rr;
  List? _image;

  List<FlSpot>? flSignal = [];

  VisitModel({
    List<FlSpot>? FlSignal,
    String? PatientName,
    String? DeviceCode,
    String? TimeReceived,
    String? PatientGender,
    String? PatientNationalCode,
    String? Description,
    List? Signals,
    int? Pcg,
    int? Paces,
    int? MasterLead,
    String? NotchFilter,
    String? EcgFilter,
    int? Wires,
    int? LeadCount,
    int? PdrReportAdrress,
    String? Tg,
    String? Ldl,
    String? Hdl,
    String? Glucose,
    int? PatientAge,
    int? Hr,
    int? Resp,
    int? Spo2,
    int? Pr,
    int? NibpSys,
    int? NibpDias,
    int? NibpMean,
    int? T1,
    int? T2,
    int? Etco2,
    int? Fico2,
    int? Rr,
    List? Image,
  }) {
    flSignal = FlSignal;
    _deviceCode = DeviceCode;
    _timeReceived = TimeReceived;
    _description = Description;
    _ecgFilter = EcgFilter;
    _etco2 = Etco2;
    _fico2 = Fico2;
    _glucose = Glucose;
    _hdl = Hdl;
    _hr = Hr;
    _image = Image;
    _ldl = Ldl;
    _leadCount = LeadCount;
    _masterLead = MasterLead;
    _nibpDias = NibpDias;
    _nibpSys = NibpSys;
    _nibpMean = NibpMean;
    _notchFilter = NotchFilter;
    _paces = Paces;
    _patientAge = PatientAge;
    _patientGender = PatientGender;
    _patientName = PatientName;
    _patientNationalCode = PatientNationalCode;
    _pcg = Pcg;
    _pdrReportAdrress = PdrReportAdrress;
    _pr = Pr;
    _resp = Resp;
    _Rr = Rr;
    _signals = Signals;
    _spo2 = Spo2;
    _t1 = T1;
    _t2 = T2;
    _tg = Tg;
    _wires = Wires;
  }

  String? get DeviceCode => _deviceCode;
  set DeviceCode(String? value) => _deviceCode = value;

  String? get TimeReceived => _timeReceived;
  set TimeReceived(String? value) => _timeReceived = value;

  String? get Description => _description;
  set Description(String? value) => _description = value;

  String? get EcgFilter => _ecgFilter;
  set EcgFilter(String? value) => _ecgFilter = value;

  String? get PatientName => _patientName;
  set PatientName(String? value) => _patientName = value;

  int? get PatientAge => _patientAge;
  set PatientAge(int? value) => _patientAge = value;

  String? get PatientGender => _patientGender;
  set PatientGender(String? value) => _patientGender = value;

  String? get PatientNationalCode => _patientNationalCode;
  set PatientNationalCode(String? value) => _patientNationalCode = value;

  List? get Signals => _signals;
  set Signals(List? value) => _signals = value;

  int? get Pcg => _pcg;
  set Pcg(int? value) => _pcg = value;

  int? get Paces => _paces;
  set Paces(int? value) => _paces = value;

  int? get MasterLead => _masterLead;
  set MasterLead(int? value) => _masterLead = value;

  String? get NotchFilter => _notchFilter;
  set NotchFilter(String? value) => _notchFilter = value;

  int? get Wires => _wires;
  set Wires(int? value) => _wires = value;

  int? get LeadCount => _leadCount;
  set LeadCount(int? value) => _leadCount = value;

  int? get PdrReportAdrress => _pdrReportAdrress;
  set PdrReportAdrress(int? value) => _pdrReportAdrress = value;

  String? get Tg => _tg;
  set Tg(String? value) => _tg = value;

  String? get Ldl => _ldl;
  set Ldl(String? value) => _ldl = value;

  String? get Hdl => _hdl;
  set Hdl(String? value) => _hdl = value;

  String? get Glucose => _glucose;
  set Glucose(String? value) => _glucose = value;

  int? get Etco2 => _etco2;
  set Etco2(int? value) => _etco2 = value;

  int? get Hr => _hr;
  set Hr(int? value) => _hr = value;

  int? get Resp => _resp;
  set Resp(int? value) => _resp = value;

  int? get Spo2 => _spo2;
  set Spo2(int? value) => _spo2 = value;

  int? get Pr => _pr;
  set Pr(int? value) => _pr = value;

  int? get NibpSys => _nibpSys;
  set NibpSys(int? value) => _nibpSys = value;

  int? get NibpDias => _nibpDias;
  set NibpDias(int? value) => _nibpDias = value;

  int? get NibpMean => _nibpMean;
  set NibpMean(int? value) => _nibpMean = value;

  int? get T1 => _t1;
  set T1(int? value) => _t1 = value;

  int? get T2 => _t2;
  set T2(int? value) => _t2 = value;

  int? get Fico2 => _fico2;
  set Fico2(int? value) => _fico2 = value;

  int? get Rr => _Rr;
  set Rr(int? value) => _Rr = value;

  List? get Image => _image;
  set Image(List? value) => _image = value;

  List<FlSpot>? get FlSignal => flSignal;
  set FlSignal(List<FlSpot>? value) => flSignal = value;

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    //print("Raw JSON data: $json");

    List<dynamic>? signalsRaw = json['Signals'] ?? [];
    print("Raw Signals List: $signalsRaw");

    List<FlSpot>? flSignalConverted = signalsRaw
        ?.expand((element) => element as List<dynamic>)
        .toList()
        .asMap()
        .entries
        .map((entry) {
      double x = entry.key.toDouble()/20;
      double y = (entry.value as num).toDouble();
      return FlSpot(x, y);
    })
        .toList();

    print("Converted FlSignal List: $flSignalConverted");

    return VisitModel(
      Image: json['Image'] ?? [],
      Rr: json['Rr'] ?? 0,
      Fico2: json['Fico2'] ?? 08,
      T2: json['T2'] ?? 0,
      T1: json['T1'] ?? 0,
      NibpMean: json['NibpMean'] ?? 0,
      NibpDias: json['NibpDias'] ?? 0,
      NibpSys: json['NibpSys'] ?? 0,
      Pr: json['Pr'] ?? 0,
      Spo2: json['Spo2'] ?? 0,
      Resp: json['Resp'] ?? 0,
      Hr: json['Hr'] ?? 0,
      Etco2: json['Etco2'] ?? 0,
      EcgFilter: json['EcgFilter'] ?? 'Ecg filter : _',
      Glucose: json['Glucose'] ?? '',
      Hdl: json['Hdl'] ?? '',
      Ldl: json['Ldl'] ?? '',
      Tg: json['Tg'] ?? '',
      PdrReportAdrress: json['PdrReportAdrress'] ?? 0,
      LeadCount: json['LeadCount'] ?? 0,
      Wires: json['Wires'] ?? 0,
      NotchFilter: json['NotchFilter'] ?? 'Notch filter : 0',
      MasterLead: json['MasterLead'] ?? 0,
      Paces: json['Paces'] ?? 0,
      Signals: signalsRaw,
      PatientNationalCode: json['PatientNationalCode'] ?? '',
      PatientGender: json['PatientGender'] ?? '',
      PatientAge: json['PatientAge'] ?? 0,
      PatientName: json['PatientName'] ?? '',
      Description: json['Description'] ?? '',
      TimeReceived: json['TimeReceived'] ?? '',
      FlSignal: flSignalConverted,
      DeviceCode: json['DeviceCode'] ?? '',
    );
  }
}