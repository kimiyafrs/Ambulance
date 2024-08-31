import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/AppValues/app_values.dart';
import '../Http/http_view_model.dart';
import '../Model/visit_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Displays a list of reports in card format.
/// When a report is tapped, it navigates to the VisitScreen and passes the selected report's visits as arguments.

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
        elevation: 12.0,
      ),
      body: Center(
        child: GetBuilder<HttpViewModel>(
          init: httpViewModel,
          builder: (controller) {
            if (controller.reports.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: controller.reports.length,
                    itemBuilder: (context, index) {
                      final report = controller.reports[index];
                      return GestureDetector(
                        onTap: () async {
                          if (report.Time != null) {
                            print('Ambulance Time: ${report.Time}');
                            try {
                              controller.setLoading(true);
                              httpViewModel.clearVisits();

                              await httpViewModel.setTime(report.Time!);
                              await httpViewModel.getVisit();

                              VisitModel selectedVisit =
                                  httpViewModel.visits.first;

                              Get.toNamed(
                                '/screen_visit',
                                arguments: {'visitModel': selectedVisit},
                              );
                            } catch (e) {
                              print('Error during time selection: $e');
                            } finally {
                              controller.setLoading(false);
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
                                  title: Text('Ambulance Code:${report.Code.toString()}'),
                                  subtitle: Text('Patient Name:${report.PatientName.toString()}'),
                                  trailing: Text(report.TimeJalali ?? ''),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  if (controller.isLoading)
                    Center(
                      child: SpinKitWave(
                        color: Colors.blue,
                        size: 50.0,
                      ),
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

