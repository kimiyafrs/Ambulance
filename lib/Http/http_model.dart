class HttpModel {
  String _token = '';
  String time = '';
  int pageIndex = 0;



  final Map<String, dynamic> postBody = {
    'Time' : 123456789,
    'UserName' : 'admin',
    'Password': 'optics1234',
  };

  late Map<String, dynamic> postDevices = {
    'Time' : 123456789,
    'PageIndex': 1,
    'Token' : token,
  };

  String get token => _token;

  set token(String value) {
    _token = value;
  }
}