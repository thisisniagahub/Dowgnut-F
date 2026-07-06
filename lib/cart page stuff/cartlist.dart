import 'package:donut_app/cart%20page%20stuff/cartlistrow.dart';
import 'package:donut_app/services/cartservice.dart';
import 'package:flutter/material.dart';

import '../models/donutmodel.dart';

class DonutShoppingList extends StatefulWidget {
  final List<DonutModel> donuts;
  final DonutShoppingCartService cartService;
  const DonutShoppingList(
      {required this.donuts, required this.cartService, super.key});

  @override
  State<DonutShoppingList> createState() => _DonutShoppingListState();
}

class _DonutShoppingListState extends State<DonutShoppingList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.donuts.length,
      itemBuilder: (context, index) {
        DonutModel currentDonut = widget.donuts[index];
        return DonutShoppingListRow(
            donut: currentDonut,
            onDeleteRow: () {
              widget.cartService.removeFromCart(currentDonut);
            });
      },
    );
  }
}
