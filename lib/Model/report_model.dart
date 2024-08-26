class ReportModel {
  String? _code;
  String? _patientName;
  String? _patientId;
  int? _time;
  String? timeJalali;

  ReportModel({
    String? Code,
    String? PatientName,
    String? PatientId,
    int? Time,
    String? TimeJalali,
  }) {
    _patientName = PatientName;
    _time = Time;
    _patientId = PatientId;
    _code = Code;
    timeJalali = TimeJalali;
  }

  String? get PatientName => _patientName;
  set PatientName(String? value) => _patientName = value;

  String? get PatientId => _patientId;
  set PatientId(String? value) => _patientId = value;

  int? get Time => _time;
  set Time(int? value) => _time = value;

  String? get TimeJalali => timeJalali;
  set TimeJalali(String? value) => timeJalali = value;

  String? get Code => _code;
  set Code(String? value) => _code = value;


  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      Code: json['Code'] ?? '0',
      PatientName: json['PatientName'] ?? '',
      PatientId: json['PatientId'] ?? '0',
      Time: json['Time'] ?? 0,
      TimeJalali: json['TimeJalali'] ?? '',
    );
  }
}