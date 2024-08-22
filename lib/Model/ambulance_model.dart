class AmbulanceModel {
  int? _time;
  String? _username;
  String? _password;
  String? _token;

  AmbulanceModel({
    int? time,
    String? username,
    String? password,
    String? token,
  }) {
    _time = time;
    _username = username;
    _password = password;
    _token = token;
  }

  String? get username => _username;
  set username(String? value) => _username = value;

  String? get password => _password;
  set password(String? value) => _password = value;

  int? get time => _time;
  set time(int? value) {
    if (value != null && value >= 1970) {
      _time = value * 1000;
    } else {
      _time = value;
    }
  }

  String? get token => _token;
  set token(String? value) => _token = value;

  factory AmbulanceModel.fromJson(Map<String, dynamic> json) {
    return AmbulanceModel(
      username: json['username'],
      time: json['time'],
      password: json['password'],
      token: json['token'],
    );
  }
}