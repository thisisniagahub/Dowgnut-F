import 'package:donut_app/cart%20page%20stuff/cartbadge.dart';
import 'package:donut_app/models/donutmodel.dart';
import 'package:donut_app/services/donutservice.dart';
import 'package:donut_app/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/cartservice.dart';
import '../theme/dowgnut_logo.dart';

class DonutShopDetails extends StatefulWidget {
  const DonutShopDetails({super.key});

  @override
  State<DonutShopDetails> createState() => _DonutShopDetailsState();
}

class _DonutShopDetailsState extends State<DonutShopDetails>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();
    rotationAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleFlavorSwipe(
    DragEndDetails details,
    DonutService donutService,
  ) {
    const double minimumSwipeVelocity = 250;
    final double velocity = details.primaryVelocity ?? 0;

    if (!donutService.hasPreviewSiblings ||
        velocity.abs() < minimumSwipeVelocity) {
      return;
    }

    if (velocity < 0) {
      donutService.previewNextDonut();
    } else {
      donutService.previewPreviousDonut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final DonutService donutService = context.watch<DonutService>();
    final DonutModel? selectedDonut = donutService.getSelectedDonut();

    if (selectedDonut == null) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Utils.mainDark),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const DowgNutLogo(size: 38),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No donut selected yet.',
                  style: TextStyle(
                    color: Utils.mainDark,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Utils.mainAppNav.currentState
                        ?.pushReplacementNamed('/main');
                  },
                  child: const Text('Return to shop'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: const [DonutShoppingCartBadge()],
        iconTheme: const IconThemeData(color: Utils.mainDark),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const DowgNutLogo(size: 38),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragEnd: (details) {
          _handleFlavorSwipe(details, donutService);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 2,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -40,
                      right: -120,
                      child: RotationTransition(
                        turns: rotationAnimation,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          child: Hero(
                            key: ValueKey(selectedDonut.name),
                            tag: selectedDonut.name,
                            child: Semantics(
                              label: '${selectedDonut.name} donut, RM ${selectedDonut.price.toStringAsFixed(2)}',
                              image: true,
                              child: Image.network(
                                selectedDonut.imgUrl,
                                width: MediaQuery.of(context).size.width * 1.25,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (donutService.hasPreviewSiblings) ...[
                      Positioned(
                        left: 18,
                        bottom: 24,
                        child: _FlavorPreviewButton(
                          icon: Icons.chevron_left_rounded,
                          semanticLabel: 'Previous flavor',
                          onPressed: donutService.previewPreviousDonut,
                        ),
                      ),
                      Positioned(
                        right: 18,
                        bottom: 24,
                        child: _FlavorPreviewButton(
                          icon: Icons.chevron_right_rounded,
                          semanticLabel: 'Next flavor',
                          onPressed: donutService.previewNextDonut,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            selectedDonut.name,
                            style: const TextStyle(
                              color: Utils.mainDark,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 50),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: Utils.mainDark,
                          ),
                          tooltip: 'Tambah ke kegemaran', // BM tooltip
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Utils.mainDark,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '\$${selectedDonut.price.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(selectedDonut.description),
                    const SizedBox(height: 20),
                    Consumer<DonutShoppingCartService>(
                      builder: ((context, cartService, child) {
                        if (!cartService.isDonutInCart(selectedDonut)) {
                          return ElevatedButton.icon(
                            onPressed: () {
                              cartService.addToCart(selectedDonut);
                            },
                            icon: const Icon(Icons.shopping_cart),
                            label: const Text('Add to Cart'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Utils.mainDark.withValues(alpha: 0.1),
                              foregroundColor: Utils.mainDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 24),
                            ),
                          );
                        }
                        return const Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_rounded,
                                color: Utils.mainDark,
                              ),
                              SizedBox(width: 20),
                              Text(
                                'Added To Cart',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Utils.mainDark,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlavorPreviewButton extends StatelessWidget {
  final IconData icon;
  final String semanticLabel;
  final VoidCallback onPressed;

  const _FlavorPreviewButton({
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.88),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
      child: IconButton(
                    tooltip: semanticLabel,
                    onPressed: onPressed,
                    icon: Icon(
                      icon,
                      color: Utils.mainDark,
                      size: 32,
                    ),
                  ),
                ),
              );
            }
      }