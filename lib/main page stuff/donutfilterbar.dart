import 'package:donut_app/models/donutfilterbaritem.dart';
import 'package:donut_app/services/donutservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../utilities.dart';

class _DonutFilterChip extends StatelessWidget {
  const _DonutFilterChip({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final DonutFilterBarItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: selected ? 1.04 : 1.0,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOutBack,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? Utils.mainColor : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected
                ? Utils.mainColor
                : Utils.mainDark.withValues(alpha: 0.12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: selected ? 0.12 : 0.05),
              blurRadius: selected ? 14 : 8,
              offset: const Offset(0, 6),
              spreadRadius: selected ? 1 : 0,
            ),
          ],
        ),
        child: Semantics(
          label: '${item.label} donut filter${selected ? ", selected" : ", not selected"}',
          button: true,
          selected: selected,
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: () {
              HapticFeedback.selectionClick();
              onTap();
            },
            child: Text(
              item.label,
              style: TextStyle(
                color: selected ? Colors.white : Utils.mainDark,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DonutFilterBar extends StatelessWidget {
  const DonutFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 0, 14),
      child: Consumer<DonutService>(
        builder: (context, value, child) {
          return SizedBox(
            height: 56,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: value.filterBarItems.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final DonutFilterBarItem item = value.filterBarItems[index];
                final bool selected = value.selectedBarItem == item.id;

                return _DonutFilterChip(
                  item: item,
                  selected: selected,
                  onTap: () => value.filteredDonutsByType(item.id),
                );
              },
            ),
          );
        },
      ),
    );
  }
}