import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';

part 'saved_visits.g.dart';

@HiveType(typeId: 1)
class SavedVisits {
  SavedVisits({
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.patientNationalCode,
    required this.FlSignal,
    required this.description,
    required this.ecgFilter,
    required this.glucose,
    required this.ldl,
    required this.hdl,
    required this.notchFilter,
    required this.tg,
    required this.fico2,
    required this.Rr,
    required this.hr,
    required this.etco2,
    required this.leadCount,
    required this.masterLead,
    required this.nibpDias,
    required this.nibpMean,
    required this.nibpSys,
    required this.paces,
    required this.pcg,
    required this.pdrReportAdrress,
    required this.pr,
    required this.resp,
    required this.spo2,
    required this.t1,
    required this.t2,
    required this.wires,
    required this.image,
  });

  @HiveField(0)
  String? patientName;

  @HiveField(1)
  int? patientAge;

  @HiveField(2)
  String? patientGender;

  @HiveField(3)
  String? patientNationalCode;

  @HiveField(4)
  String? description;

  @HiveField(5)
  String? notchFilter;

  @HiveField(6)
  String? ecgFilter;

  @HiveField(7)
  String? tg;

  @HiveField(8)
  String? ldl;

  @HiveField(9)
  String? hdl;

  @HiveField(10)
  String? glucose;

  @HiveField(11)
  int? pcg;

  @HiveField(12)
  int? paces;

  @HiveField(13)
  int? masterLead;

  @HiveField(14)
  int? wires;

  @HiveField(15)
  int? leadCount;

  @HiveField(16)
  int? pdrReportAdrress;

  @HiveField(17)
  int? hr;

  @HiveField(18)
  int? resp;

  @HiveField(19)
  int? spo2;

  @HiveField(20)
  int? pr;

  @HiveField(21)
  int? nibpSys;

  @HiveField(22)
  int? nibpDias;

  @HiveField(23)
  int? nibpMean;

  @HiveField(24)
  int? t1;

  @HiveField(25)
  int? t2;

  @HiveField(26)
  int? etco2;

  @HiveField(27)
  int? fico2;

  @HiveField(28)
  int? Rr;

  @HiveField(29)
  List? image;

  @HiveField(30)
  List<FlSpot>? FlSignal;
}
