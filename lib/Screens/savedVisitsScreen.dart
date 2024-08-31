import 'dart:typed_data';  // برای Uint8List
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:untitled2/Extension/extensions.dart';
import 'package:untitled2/Screens/saved_visits.dart';
import 'package:untitled2/widgets.dart';
import '../AppValues/app_values.dart';
import '../Chart/signal_chart.dart';

class SavedVisitsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('SaveVisitBox');

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Visits'),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return Center(child: Text('No saved visits'));
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final savedVisit = box.getAt(index) as SavedVisits;/////////////////

                Uint8List? imageBytes;

                if (savedVisit.image != null && savedVisit.image!.isNotEmpty) {
                  imageBytes = Uint8List.fromList(savedVisit.image!.cast<int>());
                }

                return Column(
                  children: [
                    buildCard(
                      context,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Patient name : ${savedVisit.patientName??''}')
                              .Style(),
                          Text('Age : ${savedVisit.patientAge??0}')
                              .Style(),
                          Text('Gender : ${savedVisit.patientGender??''}')
                              .Style(),
                          Text('National code : ${savedVisit.patientNationalCode ?? ''}')
                              .Style(),
                        ],
                      ),
                    ),
                    buildDivider(context),
                    buildCard(
                      context,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildInfoColumn(context, [
                            Text('HR : ${savedVisit.hr??0}').Style(),
                            Text('Resp : ${savedVisit.resp??0}').Style(),
                            Text('Spo2 : ${savedVisit.spo2??0}').Style(),
                            Text('PR : ${savedVisit.pr??0}').Style(),
                          ]),
                          buildInfoColumn(context, [
                            Text('Sys : ${savedVisit.nibpSys??0}').Style(),
                            Text('Dias : ${savedVisit.nibpDias??0}').Style(),
                            Text('Mean : ${savedVisit.nibpMean??0}').Style(),
                            Text('T1 : ${savedVisit.t1??0}').Style(),
                            Text('T2 : ${savedVisit.t2??0}').Style(),
                          ]),
                          buildInfoColumn(context, [
                            Text('Etco2 : ${savedVisit.etco2??0}').Style(),
                            Text('Fico2 : ${savedVisit.fico2??0}').Style(),
                            Text('RR : ${savedVisit.Rr??0}').Style(),
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
                            Text('Master lead : ${savedVisit.masterLead??0}').Style(),
                            Text('Wires : ${savedVisit.wires??0}').Style(),
                            Text('${savedVisit.ecgFilter??'Ecg Filter:0'}').Style(),
                          ]),
                          buildInfoColumn(context, [
                            Text('Lead Count : ${savedVisit.leadCount??0}').Style(),
                            Text('${savedVisit.notchFilter??'Notch Filter: 0'}').Style(),
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
                          Text('Tg : ${savedVisit.tg??'0'}').Style(),
                          Text('Ldl : ${savedVisit.ldl??'0'}').Style(),
                          Text('Hdl : ${savedVisit.hdl??'0'}').Style(),
                          Text('Glucose : ${savedVisit.glucose??'0'}').Style(),
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
                          child: Center(child: Text('Image is not available')),
                        ),
                      ),
                    buildDivider(context),
                    buildCard(
                      context,
                      child: Padding(
                        padding: EdgeInsets.all(AppValues.getWidth(context) * 0.03),
                        child: Text('Description : ${savedVisit.description ?? ''}').Style(),
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
                                signals: savedVisit.FlSignal ?? [],
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
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
