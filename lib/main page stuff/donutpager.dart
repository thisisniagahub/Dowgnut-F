import 'package:flutter/material.dart';

import '../models/donutpage.dart';
import '../theme/ascii_donut.dart';
import '../theme/dowgnut_logo.dart';
import '../theme/dowgnut_theme.dart';
import '../utilities.dart';

class DonutPager extends StatefulWidget {
  const DonutPager({super.key});

  @override
  State<DonutPager> createState() => _DonutPagerState();
}

class _DonutPagerState extends State<DonutPager> {
  int _currentPage = 0;
  late final PageController _controller;
  final List<DonutPage> pages = [
    DonutPage(imgUrl: Utils.donutPromo1, logoUrl: Utils.donutLogoWhiteText),
    DonutPage(imgUrl: Utils.donutPromo2, logoUrl: Utils.donutLogoWhiteText),
    DonutPage(imgUrl: Utils.donutPromo3, logoUrl: Utils.donutLogoRedText),
  ];

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double heroHeight =
        MediaQuery.of(context).size.width < 430 ? 300 : 360;

    return SizedBox(
      height: heroHeight,
      child: Column(
        children: [
          Expanded(
              child: PageView(
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            children: List.generate(pages.length, (index) {
              DonutPage currentPage = pages[index];
              return Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0.0, 5.0))
                    ],
                    image: DecorationImage(
                        image: NetworkImage(currentPage.imgUrl),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.topRight,
                      child: _PromoAsciiDonut(),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: DowgNutColors.neonLime.withOpacity(0.92),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const DowgNutLogo(size: 38),
                      ),
                    ),
                  ],
                ),
              );
            }),
          )),
          PageViewIndicator(
              pageController: _controller,
              currentPage: _currentPage,
              numberOfPages: pages.length),
        ],
      ),
    );
  }
}

class _PromoAsciiDonut extends StatelessWidget {
  const _PromoAsciiDonut();

  @override
  Widget build(BuildContext context) {
    final bool compact = MediaQuery.sizeOf(context).width < 430;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Utils.mainDark.withOpacity(0.78),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: DowgNutColors.neonLime.withOpacity(0.70),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: AsciiDonutWidget(
          fontSize: compact ? 3.0 : 3.8,
          width: compact ? 34 : 40,
          height: compact ? 16 : 18,
          useBrandGradient: true,
        ),
      ),
    );
  }
}

class PageViewIndicator extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final int numberOfPages;
  const PageViewIndicator(
      {required this.pageController,
      required this.currentPage,
      required this.numberOfPages,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numberOfPages, (index) {
        return GestureDetector(
          onTap: () {
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeIn,
            height: 15,
            width: 15,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: currentPage == index
                    ? Utils.mainColor
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15)),
          ),
        );
      }),
    );
  }
}
