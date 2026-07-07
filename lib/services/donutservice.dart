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

  List<DonutModel> get previewDonuts {
    final String? type = selectedDonut?.type ?? selectedBarItem;
    final List<DonutModel> donutsForType =
        Utils.donuts.where((donut) => donut.type == type).toList();

    if (donutsForType.isNotEmpty) {
      return donutsForType;
    }

    return Utils.donuts;
  }

  int get selectedPreviewIndex {
    final DonutModel? donut = selectedDonut;
    if (donut == null) {
      return 0;
    }

    final int index = previewDonuts.indexWhere(
      (previewDonut) => previewDonut.name == donut.name,
    );
    return index == -1 ? 0 : index;
  }

  bool get hasPreviewSiblings => previewDonuts.length > 1;

  void onDonutSelected(DonutModel donut) {
      selectedDonut = donut;
      notifyListeners();  // Let parent handle bottom sheet
    }

    void clearSelectedDonut() {
      selectedDonut = null;
      notifyListeners();
    }

  void previewNextDonut() {
    _previewRelativeToSelected(1);
  }

  void previewPreviousDonut() {
    _previewRelativeToSelected(-1);
  }

  void _previewRelativeToSelected(int step) {
    final List<DonutModel> donuts = previewDonuts;
    if (donuts.isEmpty) {
      return;
    }

    final int nextIndex = (selectedPreviewIndex + step) % donuts.length;
    selectedDonut =
        donuts[nextIndex < 0 ? nextIndex + donuts.length : nextIndex];
    notifyListeners();
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
