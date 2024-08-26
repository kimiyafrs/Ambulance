import 'package:get/get.dart';
import 'package:untitled2/Http/http_view_model.dart';
import 'package:untitled2/Model/ambulance_list_model.dart';
import 'package:untitled2/Model/ambulance_model.dart';
import 'package:untitled2/Model/visit_model.dart';
import 'package:untitled2/view_model.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    //Get.put(AmbulanceViewModel());
    Get.put(HttpViewModel());
    Get.put(AmbulanceListModel());
    Get.put(VisitModel());
  }
}
