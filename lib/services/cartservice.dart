import 'package:donut_app/models/donutmodel.dart';
import 'package:flutter/material.dart';

class DonutShoppingCartService extends ChangeNotifier {
  List<DonutModel> cartDonuts = [];

  void addToCart(DonutModel donut) {
    cartDonuts.add(donut);
    notifyListeners();
  }

  void removeFromCart(DonutModel donut) {
    cartDonuts.removeWhere((element) => element.name == donut.name);
    notifyListeners();
  }

  void clearCart() {
    cartDonuts.clear();
    notifyListeners();
  }

  double getTotal() {
    double cartTotal = 0.0;
    for (var element in cartDonuts) {
      cartTotal += element.price;
    }
    return cartTotal;
  }

  bool isDonutInCart(DonutModel donut) {
    return cartDonuts.any((element) => element.name == donut.name);
  }
}
