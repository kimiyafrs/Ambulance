import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import '../AppValues/app_values.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    final ValueNotifier<List<Widget>> selectedContent = ValueNotifier<List<Widget>>([]);

    final ValueNotifier<String> apiBaseUrl = ValueNotifier<String>(AppValues.API_BASE_URL);

    apiBaseUrl.addListener(() {
      print("API_BASE_URL changed to: ${apiBaseUrl.value}");
    });

    final List<String> items = ['Connection', 'Theme', 'About'];

    final Map<String, List<Widget>> buttonContent = {
      'Connection': [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 30,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Base URL',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 150,
              height: 30,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Port',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String newUrl = _controller.text.trim();
                apiBaseUrl.value = newUrl;
                AppValues.updateBaseUrl(newUrl);
                Get.snackbar('Success', 'Base URL updated to: ${apiBaseUrl.value}');
              },
              child: Text('Confirm :)'),
            ),
          ],
        ),
      ],
      'Theme': [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.changeTheme(ThemeData.dark());
              },
              child: Row(
                children: [
                  Text('Dark '),
                  Icon(
                    FontAwesomeIcons.solidMoon,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.changeTheme(ThemeData.light());
              },
              child: Row(
                children: [
                  Text('Light '),
                  Icon(
                    FontAwesomeIcons.solidSun,
                    color: Colors.amberAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
      'About': [
        Center(child: Text('About App')),
      ],
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      backgroundColor: Colors.cyan,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    items[index],
                    style: TextStyle(fontSize: 14),
                  ),
                  onTap: () {
                    selectedContent.value = buttonContent[items[index]]!;
                  },
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(AppValues.getWidth(context) * 0.005),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ValueListenableBuilder<List<Widget>>(
                    valueListenable: selectedContent,
                    builder: (context, value, child) {
                      if (value.isEmpty) {
                        return Text('You did not select an option!');
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: value,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
