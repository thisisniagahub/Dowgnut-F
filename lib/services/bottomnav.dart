import 'package:flutter/material.dart';

import '../utilities.dart';

class DonutBarSelectionService extends ChangeNotifier {
  String tabSelection = 'main';

  void setTabSelection(String value) {
    Utils.mainListNav.currentState?.pushReplacementNamed('/$value');
    tabSelection = value;
    notifyListeners();
  }
}
