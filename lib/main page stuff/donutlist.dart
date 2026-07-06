import 'package:flutter/material.dart';

import '../models/donutmodel.dart';
import 'donutcard.dart';

class DonutList extends StatelessWidget {
  final List<DonutModel> donuts;
  const DonutList({required this.donuts, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final int crossAxisCount = width >= 720
            ? 4
            : width >= 520
                ? 3
                : 2;
        final double childAspectRatio = width < 380 ? 0.68 : 0.72;

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 28),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: donuts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 14,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) => DonutCard(donutInfo: donuts[index]),
        );
      },
    );
  }
}
