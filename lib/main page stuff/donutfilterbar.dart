import 'package:donut_app/models/donutfilterbaritem.dart';
import 'package:donut_app/services/donutservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities.dart';

class DonutFilterBar extends StatelessWidget {
  const DonutFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 0, 14),
      child: Consumer<DonutService>(builder: ((context, value, child) {
        return SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: value.filterBarItems.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final DonutFilterBarItem item = value.filterBarItems[index];
              final bool selected = value.selectedBarItem == item.id;

              return InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: () => value.filteredDonutsByType(item.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    color: selected ? Utils.mainColor : Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: selected
                          ? Utils.mainColor
                          : Utils.mainDark.withOpacity(0.12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(selected ? 0.10 : 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Text(
                    item.label,
                    style: TextStyle(
                      color: selected ? Colors.white : Utils.mainDark,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      })),
    );
  }
}
