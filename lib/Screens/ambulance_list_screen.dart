import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Http/http_view_model.dart';
import '../Model/ambulance_list_model.dart';
import '../view_model.dart';

class AmbulanceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final httpViewModel = Get.find<HttpViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Ambulance List'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx((){if (httpViewModel.ambulances.isEmpty){
          httpViewModel.getAmbulanceList();
          return Container();
    }
    return ListView.builder(itemCount:httpViewModel.ambulances.length,
        itemBuilder: (context, index) {
    final ambulance = httpViewModel.ambulances[index];
    return ListTile(
    title: Text(ambulance.id.toString() ?? ''),
    subtitle: Column(
    children: [
    Text(ambulance.code ?? ''),
    Text(ambulance.isVisible.toString() ??'false'),
    Text(ambulance.description ?? ''),
    Text(ambulance.token ?? '')
    ],
    ),
    );
    }
              );

        })
      )

              );
  }

 }