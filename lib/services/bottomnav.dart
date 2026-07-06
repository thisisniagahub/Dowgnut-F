import 'package:flutter/material.dart';

import '../utilities.dart';

class DonutBarSelectionService extends ChangeNotifier {
  String tabSelection = 'main';

  void setTabSelection(String value) {
    Utils.mainListnav.currentState?.pushReplacementNamed('/$value');
    tabSelection = value;
    notifyListeners();
  }
}
