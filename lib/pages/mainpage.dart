import 'package:donut_app/main%20page%20stuff/donutfilterbar.dart';
import 'package:donut_app/main%20page%20stuff/donutpager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main page stuff/donutlist.dart';
import '../services/donutservice.dart';

class DonutMainPage extends StatelessWidget {
  const DonutMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 96),
      children: [
        const DonutPager(),
        const DonutFilterBar(),
        Consumer<DonutService>(
          builder: (context, value, child) => DonutList(
            donuts: value.filteredDonuts,
          ),
        )
      ],
    );
  }
}
