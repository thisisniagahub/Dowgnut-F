import 'package:donut_app/cart%20page%20stuff/cartlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/cartservice.dart';
import '../utilities.dart';

class DonutShoppingCartPage extends StatefulWidget {
  const DonutShoppingCartPage({super.key});

  @override
  State<DonutShoppingCartPage> createState() => _DonutShoppingCartPageState();
}

class _DonutShoppingCartPageState extends State<DonutShoppingCartPage>
    with SingleTickerProviderStateMixin {
  AnimationController? titleAnimation;

  @override
  void initState() {
    titleAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..forward();
    super.initState();
  }

  @override
  void dispose() {
    titleAnimation!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                parent: titleAnimation!, curve: Curves.easeInOut)),
            child: Image.network(
              Utils.donutTitleMyDonuts,
              width: 170,
            ),
          ),
          Expanded(
              child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Consumer<DonutShoppingCartService>(
              builder: (context, value, child) {
                if (value.cartDonuts.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 50,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'You don\'t have any items in your cart',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                }
                return DonutShoppingList(
                  donuts: value.cartDonuts,
                  cartService: value,
                );
              },
            ),
          )),
          Consumer<DonutShoppingCartService>(
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  value.cartDonuts.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Total',
                                style: TextStyle(
                                  color: Utils.mainDark,
                                )),
                            Text('\$${value.getTotal().toStringAsFixed(2)}',
                                style: const TextStyle(
                                    color: Utils.mainDark,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold))
                          ],
                        )
                      : Container(),
                  //clear cart button
                  GestureDetector(
                    onTap: (() {
                      value.clearCart();
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                                                color: value.cartDonuts.isEmpty
                                                    ? Colors.grey.withValues(alpha: 0.4)
                                                    : Utils.mainColor.withValues(alpha: 0.4),
                                                borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.delete_forever_rounded,
                            color: value.cartDonuts.isEmpty
                                ? Colors.grey
                                : Utils.mainDark,
                          ),
                          Text(
                            'Clear cart',
                            style: TextStyle(
                                color: value.cartDonuts.isEmpty
                                    ? Colors.grey
                                    : Utils.mainDark),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
