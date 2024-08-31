import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:untitled2/Screens/saved_visits.dart';
import '../Chart/signal_chart.dart';
import '../Extension/extensions.dart';
import '../AppValues/app_values.dart';
import 'dart:typed_data';
import '../Http/http_view_model.dart';
import '../Model/visit_model.dart';
import '../widgets.dart';

/// Displays the visit details based on the selected report from the ReportScreen.
/// The visit information is presented in various cards, and if an image is available, it is shown.
/// The screen also includes a chart to display signal data if provided.
class VisitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final VisitModel visitModel = Get.arguments['visitModel'];

    Uint8List? imageBytes;

    if (visitModel.Image!.isNotEmpty) {
      imageBytes = Uint8List.fromList(visitModel.Image!.cast<int>());
    } else {
      print('Image is not available');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visits',
          style: TextStyle(color: Colors.indigo),
        ),
        elevation: 12.0,
        centerTitle: true,
      ),
      body:  GetBuilder<HttpViewModel>(
          builder: (controller) {
            if (controller.isLoading) {

              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 50.0,
                ),
              );
            } else {
              return
                SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildCard(
                            context,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Patient name : ${visitModel.PatientName}')
                                    .Style(),
                                Text(
                                    'Age : ${visitModel.PatientAge.toString()}')
                                    .Style(),
                                Text('Gender : ${visitModel.PatientGender}')
                                    .Style(),
                                Text('National code : ${visitModel
                                    .PatientNationalCode ?? ''}')
                                    .Style(),
                              ],
                            ),
                          ),
                          buildDivider(context),
                          buildCard(
                            context,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // Center row content
                              children: [
                                buildInfoColumn(context, [
                                  Text('HR : ${visitModel.Hr.toString()}')
                                      .Style(),
                                  Text('Resp : ${visitModel.Resp.toString()}')
                                      .Style(),
                                  Text('Spo2 : ${visitModel.Spo2.toString()}')
                                      .Style(),
                                  Text('PR : ${visitModel.Pr.toString()}')
                                      .Style(),
                                ]),
                                buildInfoColumn(context, [
                                  Text('Sys : ${visitModel.NibpSys.toString()}')
                                      .Style(),
                                  Text('Dias : ${visitModel.NibpDias
                                      .toString()}').Style(),
                                  Text('Mean : ${visitModel.NibpMean
                                      ?.toString()}').Style(),
                                  Text('T1 : ${visitModel.T1.toString()}')
                                      .Style(),
                                  Text('T2 : ${visitModel.T2.toString()}')
                                      .Style(),
                                ]),
                                buildInfoColumn(context, [
                                  Text('Etco2 : ${visitModel.Etco2.toString()}')
                                      .Style(),
                                  Text('Fico2 : ${visitModel.Fico2.toString()}')
                                      .Style(),
                                  Text('RR : ${visitModel.Rr?.toString()}')
                                      .Style(),
                                ]),
                              ],
                            ),
                          ),
                          buildDivider(context),
                          buildCard(
                            context,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildInfoColumn(context, [
                                  Text('Master lead : ${visitModel.MasterLead}')
                                      .Style(),
                                  Text('Wires : ${visitModel.Wires.toString()}')
                                      .Style(),
                                  Text('${visitModel.EcgFilter.toString()}')
                                      .Style(),
                                ]),
                                buildInfoColumn(context, [
                                  Text('Lead Count : ${visitModel.LeadCount
                                      ?.toString()}')
                                      .Style(),
                                  Text('${visitModel.NotchFilter?.toString()}')
                                      .Style(),
                                ]),
                              ],
                            ),
                          ),
                          buildDivider(context),
                          buildCard(
                            context,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tg : ${visitModel.Tg?.toString()}')
                                    .Style(),
                                Text('Ldl : ${visitModel.Ldl?.toString()}')
                                    .Style(),
                                Text('Hdl : ${visitModel.Hdl?.toString()}')
                                    .Style(),
                                Text('Glucose : ${visitModel.Glucose}').Style(),
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
                                  height: AppValues.getHight(context) * 0.3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          else
                            buildCard(
                              context,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Center(child: Text(
                                    'Image is not available')),
                              ),
                            ),
                          buildDivider(context),
                          buildCard(
                            context,
                            child: Padding(
                              padding: EdgeInsets.all(AppValues.getWidth(
                                  context) * 0.03),
                              child: Text('Description : ${visitModel
                                  .Description ?? ''}')
                                  .Style(),
                            ),
                          ),
                          buildDivider(context),
                          buildCard(
                            context,
                            child: Padding(
                              padding:
                              EdgeInsets.all(MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.03),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Signal :').Style(),
                                  SizedBox(
                                    height: 400,
                                    child: SignalChart(
                                      signals: visitModel.FlSignal ?? [],
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
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                final box = Hive.box('SaveVisitBox');
                                final savedVisit = SavedVisits(
                                  patientName: visitModel.PatientName,
                                  patientAge: visitModel.PatientAge,
                                  patientGender: visitModel.PatientGender,
                                  patientNationalCode: visitModel.PatientNationalCode,
                                  FlSignal: visitModel.FlSignal,
                                  description:visitModel.Description,
                                  ecgFilter: visitModel.EcgFilter,
                                  glucose: visitModel.Glucose,
                                  hdl:visitModel.Hdl,
                                  notchFilter:visitModel.NotchFilter,
                                  tg:visitModel.Tg,
                                  fico2:visitModel.Fico2,
                                  Rr:visitModel.Rr,
                                  hr:visitModel.Hr,
                                  etco2:visitModel.Etco2,
                                  leadCount:visitModel.LeadCount,
                                  masterLead:visitModel.MasterLead,
                                  nibpDias:visitModel.NibpDias,
                                  nibpSys: visitModel.NibpSys,
                                  nibpMean: visitModel.NibpMean,
                                  paces:visitModel.Paces,
                                  pcg:visitModel.Pcg,
                                  pdrReportAdrress:visitModel.PdrReportAdrress,
                                  pr:visitModel.Pr,
                                  resp:visitModel.Resp,
                                  spo2:visitModel.Spo2,
                                  t1: visitModel.T1,
                                  t2: visitModel.T2,
                                  ldl: visitModel.Ldl,
                                    wires:visitModel.Wires,
                                  image: visitModel.Image,

                                );
                                await box.add(savedVisit);


                                Get.snackbar('Saved', 'This visit has been saved',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white);
                              } catch (e) {

                                Get.snackbar('Error', 'Failed to save visit',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                                print('Error saving visit: $e');
                              }
                            },
                            child: Text('Save'),
                          ),

                        ],
                      ),
                    )
                );
            }
          }
      ),

    );
  }
}



