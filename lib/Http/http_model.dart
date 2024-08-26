import 'package:shamsi_date/shamsi_date.dart';


class HttpModel {
  String _token = '';
  //String time = '';
  String code = '';
  int pageIndex = 0;
  int timeReceived = 0;
  late DateTime now;
  late DateTime from;
  late DateTime to;
  late DateTime dateShamsi;


  HttpModel() {
    now = DateTime.now();
    from = now.subtract(Duration(days: 300));
    to = now;



  }

  final Map<String, dynamic> postBody = {
    'Time': 123456789,
    'UserName': 'admin',
    'Password': 'optics1234',
  };

  Map<String, dynamic> get postDevices => {
        'Time': 123456789,
        'PageIndex': 1,
        'Token': _token,
      };

  Map<String, dynamic> get postReport => {
        'Token': _token,
        'AmbCode': code.trim(),
        'From': from.millisecondsSinceEpoch,
        //
        'To': to.millisecondsSinceEpoch,
        //
      };

  Map<String, dynamic> get postFile => {
        'TimeReceived': timeReceived,
        'Token': _token,
        'DeviceCode': code,
      };

  String get token => _token;

  set token(String value) {
    _token = value;
  }
}
