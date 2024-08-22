class AmbulanceListModel {
  int? _id;
  String? _code;
  String? _descreption;
  String? _token;
  bool? _isVisible;

  AmbulanceListModel(
      {int? id, String? descreption, String? token, code, bool? isVisible}) {
    _code = code;
    _descreption = descreption;
    _id = id;
    _isVisible = isVisible;
    _token = token;
  }

  int? get id => _id;
  set id(int? value) => _id = value;

  String? get code => _code;
  set code(String? value) => _code = value;

  String? get description => _descreption;
  set description(String? value) => _descreption = value;

  String? get token => _token;
  set token(String? value) => _token = value;

  bool? get isVisible => _isVisible;
  set isVisible(bool? value) => _isVisible = value;

  factory AmbulanceListModel.fromJson(Map<String, dynamic> json) {
    return AmbulanceListModel(
      id: json['Id'],
      code: json['Code'],
      token: json['Token'],
      isVisible:json ['IsVisible'],
      descreption: json['Description'],
    );
  }
}
