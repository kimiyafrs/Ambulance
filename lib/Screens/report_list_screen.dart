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

                          //selectedIndex = index;

                          VisitModel selectedVisit = httpViewModel.visits.first;


                          Get.toNamed(
                            '/screen_visit',
                            arguments: {'visitModel': selectedVisit},
                          );
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
                      margin: EdgeInsets.all(AppValues.getWidth(context) * 0.03),
                      child: Padding(
                        padding: EdgeInsets.all(AppValues.getWidth(context) * 0.005),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(report.Code.toString()),
                              subtitle: Text(report.PatientName.toString()),
                              trailing: Text(report.TimeJalali ?? ''),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:untitled2/AppValues/app_values.dart';
// import '../Http/http_view_model.dart';
// import '../Model/visit_model.dart';

/// Displays a list of reports in card format.
/// When a report is tapped, it navigates to the VisitScreen and passes the selected report's visits as arguments.
/// Allows the user to select a specific visit from the list of visits for the selected report.
//
// class ReportScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final httpViewModel = Get.find<HttpViewModel>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Reports',
//           style: TextStyle(color: Colors.indigo),
//         ),
//         centerTitle: true,
//         elevation: 12.0,
//       ),
//       body: Center(
//         child: GetBuilder<HttpViewModel>(
//           init: httpViewModel,
//           builder: (controller) {
//             if (controller.reports.isEmpty) {
//               return Center(child: CircularProgressIndicator());
//             } else {
//               return ListView.builder(
//                 itemCount: controller.reports.length,
//                 itemBuilder: (context, index) {
//                   final report = controller.reports[index];
//                   return GestureDetector(
//                     onTap: () async {
//                       if (report.Time != null) {
//                         print('Report Time: ${report.Time}');
//                         try {
//                           httpViewModel.clearVisits();
//
//                           await httpViewModel.setTime(report.Time!);
//                           await httpViewModel.getVisit();
//
//                           // Navigate to a screen where the user can select a specific visit
//                           Get.to(() => VisitSelectionScreen());
//                         } catch (e) {
//                           print('Error during time selection: $e');
//                         }
//                       } else {
//                         print('Error: Time is null.');
//                       }
//                     },
//                     child: Card(
//                       color: Colors.cyan.shade300,
//                       elevation: 12.0,
//                       margin: EdgeInsets.all(AppValues.getWidth(context) * 0.03),
//                       child: Padding(
//                         padding: EdgeInsets.all(AppValues.getWidth(context) * 0.005),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ListTile(
//                               title: Text(report.Code.toString()),
//                               subtitle: Text(report.PatientName.toString()),
//                               trailing: Text(report.TimeJalali ?? ''),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
//
// /// Screen for selecting a specific visit from the list of visits.
// /// Displays a list of visits and allows the user to select one.
// class VisitSelectionScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final httpViewModel = Get.find<HttpViewModel>();
//     final visits = httpViewModel.visits;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Select Visit',
//           style: TextStyle(color: Colors.indigo),
//         ),
//         centerTitle: true,
//         elevation: 12.0,
//       ),
//       body: ListView.builder(
//         itemCount: visits.length,
//         itemBuilder: (context, index) {
//           final visit = visits[index];
//           return ListTile(
//             title: Text(visit.PatientName ?? 'No Name'),
//             subtitle: Text('Time: ${visit.Time}'),
//             onTap: () {
//               // Navigate to the VisitScreen with the selected visit
//               Get.toNamed(
//                 '/screen_visit',
//                 arguments: {'visitModel': visit},
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }