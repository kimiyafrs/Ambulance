import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Chart/signal_chart.dart';
import '../Extension/extensions.dart';
import '../Http/http_view_model.dart';
import '../AppValues/app_values.dart';
import 'dart:typed_data';
import '../Model/visit_model.dart';

class VisitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpViewModel httpViewModel = Get.find<HttpViewModel>();
    final VisitModel visitModel = Get.find<VisitModel>();
    //final Map<String, dynamic> arguments = Get.arguments;
    // final String? time = arguments['time'];
    // final String? ambulanceCode = arguments['ambulanceCode'];
    //final String? patientName = arguments['patientName'];


    print(visitModel.FlSignal);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Visit List',
            style: TextStyle(color: Colors.indigo),
          ),
          elevation: 12.0,
          centerTitle: true,
        ),
        body: GetBuilder<HttpViewModel>(
            init: httpViewModel,
            builder: (controller) {

              //final String timeAsString = time?.toString() ?? '';

              //final filteredVisits = controller.visits.where((visit) {

                //print("Visit TimeReceived: ${visit.TimeReceived}, Visit DeviceCode: ${visit.DeviceCode}, Visit PatientName: ${visit.PatientName}");

                //return
                  // visit.TimeReceived?.trim() == timeAsString.trim() &&
                  //   visit.DeviceCode?.trim() == ambulanceCode?.trim() &&
                    //visit.PatientName?.trim() == patientName?.trim();
             // }
                // ).toList();

             // print('Filtered Visits Count: ${filteredVisits.length}');

              if (controller.visits.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: controller.visits.length,
                    itemBuilder: (context, index) {
                      var visit = controller.visits[index];
                      Uint8List? imageBytes;

                      if (visit.Image!.isNotEmpty) {
                        imageBytes =
                            Uint8List.fromList(visit.Image!.cast<int>());
                      } else {
                        print('Image is not available');
                      }

                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildCard(
                                  context,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text('Patient name : ${visit.PatientName}')
                                          .Style(),
                                      Text('Age : ${visit.PatientAge.toString() }')
                                          .Style(),
                                      Text('Gender : ${visit.PatientGender}')
                                          .Style(),
                                      Text('National code : ${visit.PatientNationalCode ?? ''}')
                                          .Style(),
                                    ],
                                  ),
                                ),
                                buildDivider(context),
                                buildCard(
                                  context,
                                  child: Row(
                                    children: [
                                      buildInfoColumn(context, [
                                        Text('HR : ${visit.Hr.toString()}')
                                            .Style(),
                                        Text('Resp : ${visit.Resp.toString() }')
                                            .Style(),
                                        Text('Spo2 : ${visit.Spo2.toString() }')
                                            .Style(),
                                        Text('PR : ${visit.Pr.toString() }')
                                            .Style(),
                                      ]),

                                      buildInfoColumn(context, [
                                        Text('Sys : ${visit.NibpSys.toString()}')
                                            .Style(),
                                        Text('Dias : ${visit.NibpDias.toString()}')
                                            .Style(),
                                        Text('Mean : ${visit.NibpMean?.toString()}')
                                            .Style(),
                                        Text('T1 : ${visit.T1.toString() }')
                                            .Style(),
                                        Text('T2 : ${visit.T2.toString() }')
                                            .Style(),
                                      ]),


                                      buildInfoColumn(context, [
                                        Text('Etco2 : ${visit.Etco2.toString()}')
                                            .Style(),
                                        Text('Fico2 : ${visit.Fico2.toString() }')
                                            .Style(),
                                        Text('RR : ${visit.Rr?.toString() }')
                                            .Style(),
                                      ]),

                                    ],
                                  ),
                                ),
                                buildDivider(context),
                                buildCard(
                                  context,
                                  child: Row(
                                    children: [
                                      buildInfoColumn(context, [
                                        Text('Master lead : ${visit.MasterLead }')
                                            .Style(),
                                        Text('Wires : ${visit.Wires.toString() }')
                                            .Style(),
                                        Text(' ${visit.EcgFilter.toString() }')
                                            .Style(),
                                      ]),

                                      buildInfoColumn(context, [
                                        Text('Lead Count : ${visit.LeadCount?.toString() }')
                                            .Style(),
                                        Text(' ${visit.NotchFilter?.toString() }')
                                            .Style(),
                                      ]),

                                    ],
                                  ),
                                ),
                                buildDivider(context),
                                buildCard(
                                  context,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text('Tg : ${visit.Tg?.toString() }')
                                          .Style(),
                                      Text('Ldl : ${visit.Ldl?.toString() }')
                                          .Style(),
                                      Text('Hdl : ${visit.Hdl?.toString() }')
                                          .Style(),
                                      Text('Glucose : ${visit.Glucose }')
                                          .Style(),
                                    ],
                                  ),
                                ),
                                buildDivider(context),
                                if (imageBytes != null)
                                  buildCard(
                                    context,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Image.memory(
                                        imageBytes,
                                        height:
                                        AppValues.getHight(context) * 0.3,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                else if (imageBytes == null)
                                  buildCard(
                                    context,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Center(
                                          child:
                                          Text('Image is not available')),
                                    ),
                                  ),
                                buildDivider(context),
                                buildCard(
                                  context,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        AppValues.getWidth(context) * 0.03),
                                    child: Text(
                                        'Description : ${visit.Description ?? ''}')
                                        .Style(),
                                  ),
                                ),
                                buildDivider(context),
                                buildCard(
                                  context,
                                  child: Padding(
                                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Signal :').Style(),
                                        SizedBox(
                                          height: 400,
                                          child: SignalChart(
                                            signals: visit.FlSignal ?? [],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppValues.getHight(context) * 0.08,
                                  width: AppValues.getWidth(context) * 0.8,
                                  child: Divider(
                                    color: Colors.indigo,
                                    height: AppValues.getHight(context) * 1,
                                    thickness: 4,
                                  ),
                                )
                              ]));
                    });
              }
            }));
  }
}

Widget buildCard(BuildContext context, {required Widget child}) {
  return SizedBox(
    width: AppValues.getWidth(context) * 0.9,
    child: Card(
      elevation: 10.0,
      color: Colors.cyan.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.blue, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppValues.getWidth(context) * 0.03),
        child: child,
      ),
    ),
  );
}

Widget buildInfoColumn(BuildContext context, List<Widget> children) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
}

Widget buildDivider(BuildContext context) {
  return SizedBox(
    height: AppValues.getHight(context) * 0.03,
    width: AppValues.getWidth(context) * 0.8,
    child: Divider(
      color: Colors.blue,
      height: AppValues.getHight(context) * 0.1,
      thickness: 2,
    ),
  );
}