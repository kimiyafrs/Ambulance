
class RequestModel {
  String? _token;
  int? _time;
  int? _pageIndex;

  RequestModel({String? token, int? time, int? pageIndex}) {
    _token = token;
    _time = time;
    _pageIndex = pageIndex;
  }

  String? get token => _token;
  set token(String? value) => _token = value;

  int? get time => _time;
  set time(int? value) => _time = value;

  int? get pageIndex => _pageIndex;
  set pageIndex(int? value) => _pageIndex = value;

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      token: json['Token'],
      time: json['Time'],
      pageIndex: json['PageIndex'],
    );
  }
}
