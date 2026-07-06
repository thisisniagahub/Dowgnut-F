import 'package:donut_app/services/cartservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities.dart';

class DonutShoppingCartBadge extends StatelessWidget {
  const DonutShoppingCartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DonutShoppingCartService>(
      builder: ((context, value, child) {
        if (value.cartDonuts.isEmpty) {
          return const SizedBox();
        }
        return Transform.scale(
          scale: 0.7,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Utils.mainColor),
            child: Row(
              children: [
                Text(
                  '${value.cartDonuts.length}',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.shopping_cart,
                  size: 25,
                  color: Colors.white,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
