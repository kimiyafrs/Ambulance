import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/AppValues/app_values.dart';
import 'package:untitled2/Screens/visit_list_screen.dart';
import '../Http/http_view_model.dart';

int? selectedIndex;

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final httpViewModel = Get.find<HttpViewModel>();

    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Reports',
              style: TextStyle(color: Colors.indigo),
            ),
            centerTitle: true,
            elevation: 12.0),
        body: Center(
          child: GetBuilder<HttpViewModel>(
              init: httpViewModel,
              builder: (controller) {
                if (controller.reports.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      itemCount: controller.reports.length,
                      itemBuilder: (context, index) {
                        final report = controller.reports[index];
                        return GestureDetector(
                          onTap: () async {
                            if (report.Time != null) {
                              print('Ambulance Time: ${report.Time}');
                              try {
                                httpViewModel.clearVisits();

                                await httpViewModel.setTime(report.Time!);
                                await httpViewModel.getVisit();

                                selectedIndex = index;

                                Get.toNamed(
                                  '/screen_visit',
                                  // arguments: {
                                  //   // 'time': report.Time.toString(),
                                  //   // 'ambulanceCode': report.Code,
                                  //   'patientName': report.PatientName,
                                  // },
                                );

                                //Get.to(VisitScreen());
                                // Get.toNmade('/ambulance_screen');
                              } catch (e) {
                                print('Error during time selection: $e');
                              }
                            } else {
                              print('Error: time is null.');
                            }
                          },
                          child: Card(
                            color: Colors.cyan.shade300,
                            elevation: 12.0,
                            margin: EdgeInsets.all(
                                AppValues.getWidth(context) * 0.03),
                            child: Padding(
                              padding: EdgeInsets.all(
                                  AppValues.getWidth(context) * 0.005),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(report.Code.toString()),
                                    subtitle:
                                        Text(report.PatientName.toString()),
                                    trailing: Text(report.TimeJalali ?? ''),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              }),
        ));
  }
}
