import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../AppValues/app_values.dart';

extension textStyle on Text {
  Text Style() {
    return Text(
      this.data!,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        fontFamily: 'SourceSansPro',
      ),
    );
  }
}

