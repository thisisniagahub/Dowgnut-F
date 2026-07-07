import 'package:donut_app/initial%20page%20stuff/bottombar.dart';
import 'package:donut_app/pages/cartpage.dart';
import 'package:donut_app/pages/mainpage.dart';
import 'package:donut_app/initial%20page%20stuff/sidebar.dart';
import 'package:flutter/material.dart';

import '../theme/dowgnut_logo.dart';
import '../utilities.dart';

class DonutShopMain extends StatefulWidget {
  const DonutShopMain({super.key});

  @override
  State<DonutShopMain> createState() => _DonutShopMainState();
}

class _DonutShopMainState extends State<DonutShopMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(
          child: DonutSideMenu(),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Utils.mainDark),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const DowgNutLogo(size: 42),
        ),
        body: Column(
          children: [
            Expanded(
                          child: Navigator(
                            key: Utils.mainListNav,
                            initialRoute: '/main',
                onGenerateRoute: (settings) {
                  Widget page;
                  switch (settings.name) {
                    case '/main':
                      page = const DonutMainPage();
                      break;
                    case '/favorite':
                      page = const Center(
                        child: Text('favorites'),
                      );
                      break;
                    case '/shoppingCart':
                      page = const DonutShoppingCartPage();
                      break;
                    default:
                      page = const Center(
                        child: Text('main'),
                      );
                      break;
                  }
                  return PageRouteBuilder(
                      pageBuilder: ((context, animation, secondaryAnimation) =>
                          page),
                      transitionDuration: const Duration(seconds: 0));
                },
              ),
            ),
            const DonutBottomBar(),
          ],
        ));
  }
}
