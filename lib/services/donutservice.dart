import 'package:donut_app/models/donutfilterbaritem.dart';
import 'package:flutter/cupertino.dart';

import '../models/donutmodel.dart';
import '../utilities.dart';

class DonutService extends ChangeNotifier {
  String? selectedBarItem;
  List<DonutModel> filteredDonuts = [];
  DonutModel? selectedDonut;

  DonutModel? getSelectedDonut() {
    return selectedDonut;
  }

  void onDonutSelected(DonutModel donut) {
    selectedDonut = donut;
    Utils.mainAppNav.currentState?.pushNamed('/details');
  }

  DonutService() {
    selectedBarItem = filterBarItems.first.id;
    filteredDonutsByType(selectedBarItem!);
  }

  List<DonutFilterBarItem> filterBarItems = [
    DonutFilterBarItem(id: 'classic', label: 'Classic'),
    DonutFilterBarItem(id: 'sprinkled', label: 'Sprinkled'),
    DonutFilterBarItem(id: 'stuffed', label: 'Stuffed')
  ];

  void filteredDonutsByType(String type) {
    selectedBarItem = type;
    filteredDonuts = Utils.donuts
        .where(
          (element) => element.type == selectedBarItem,
        )
        .toList();
    notifyListeners();
  }
}
