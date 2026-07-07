import 'package:donut_app/services/donutservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/donutmodel.dart';
import '../utilities.dart';

class DonutCard extends StatelessWidget {
  final DonutModel donutInfo;
  const DonutCard({required this.donutInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${donutInfo.name} donut, RM ${donutInfo.price.toStringAsFixed(2)}',
      button: true,
      child: GestureDetector(
        onTap: () {
          var donutService = Provider.of<DonutService>(context, listen: false);
          donutService.onDonutSelected(donutInfo);
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 14,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Semantics(
                    label: '${donutInfo.name} donut image',
                    image: true,
                    child: Hero(
                      tag: donutInfo.name,
                      child: Image.network(
                        donutInfo.imgUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                donutInfo.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Utils.mainDark,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Utils.mainColor,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '\$${donutInfo.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}