import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:untitled2/Extension/extensions.dart';
import 'package:untitled2/Screens/report_list_screen.dart';
import 'package:untitled2/Screens/visit_list_screen.dart';
import '../AppValues/app_values.dart';
import '../Http/http_view_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AmbulanceListController extends GetxController {
  var selectedIndex = 0.obs;

  void onTabChange(int index) {
    selectedIndex.value = index;
  }
}

class AmbulanceListScreen extends StatelessWidget {
  final AmbulanceListController controller = Get.put(AmbulanceListController());

  @override
  Widget build(BuildContext context) {
    final httpViewModel = Get.find<HttpViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ambulance List',
          style: TextStyle(color: Colors.indigo),
        ),
        elevation: 15.0,
        centerTitle: true,
        leading: Icon(Icons.arrow_back, color: Colors.indigo),
        actions: [
          GetBuilder<HttpViewModel>(builder: (httpViewModel) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                color: Colors.indigo,
                httpViewModel.isConnected.value
                    ? Icons.wifi
                    : Icons.signal_wifi_connected_no_internet_4_outlined,
              ),
            );
          })
        ],
      ),
      body: Center(
        child: GetBuilder<HttpViewModel>(
          init: httpViewModel,
          builder: (httpViewModel) {
            if (httpViewModel.ambulances.isEmpty) {
              return FutureBuilder(
                future: httpViewModel.getAmbulanceList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      itemCount: httpViewModel.ambulances.length,
                      itemBuilder: (context, index) {
                        final ambulance = httpViewModel.ambulances[index];
                        return Card(
                          elevation: 12.0,
                          margin: EdgeInsets.all(
                              AppValues.getWidth(context) * 0.03),
                          child: Padding(
                            padding: EdgeInsets.all(
                                AppValues.getWidth(context) * 0.005),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(ambulance.id.toString()).Style(),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(ambulance.code ?? 'No code').Style(),
                                      Text(ambulance.isVisible.toString())
                                          .Style(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              );
            } else {
              return ListView.builder(
                itemCount: httpViewModel.ambulances.length,
                itemBuilder: (context, index) {
                  final ambulance = httpViewModel.ambulances[index];
                  return GestureDetector(
                    onTap: () async {
                      if (ambulance.code != null &&
                          ambulance.code!.isNotEmpty) {
                        print('Ambulance code: ${ambulance.code}');
                        try {
                          await httpViewModel.setAmbCode(ambulance.code!);
                          await httpViewModel.getReport();
                          Get.toNamed('/screen_report');
                        } catch (e) {
                          print('Error during ambulance selection: $e');
                        }
                      } else {
                        print('Error: Ambulance code is null or empty.');
                      }
                    },
                    child: Card(
                      color: Colors.cyan,
                      elevation: 12.0,
                      margin:
                      EdgeInsets.all(AppValues.getWidth(context) * 0.03),
                      child: Padding(
                        padding:
                        EdgeInsets.all(AppValues.getWidth(context) * 0.005),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(ambulance.id.toString()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(ambulance.code ?? 'No code'),
                                  Text(ambulance.isVisible.toString()),
                                ],
                              ),
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Obx(() => GNav(
            rippleColor: Colors.blue[300]!,
            hoverColor: Colors.blue[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.blue[100]!,
            color: Colors.black,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Setting',
              ),
            ],
            selectedIndex: controller.selectedIndex.value,
            onTabChange: (index) {
              controller.onTabChange(index);

              // Ensure the navigation route exists before navigating
              if (index == 1) {
                if (Get.isRegistered<HttpViewModel>()) {
                  Get.toNamed('/Setting');
                }
              }
            },
          )),
        ),
      ),
    );
  }
}
