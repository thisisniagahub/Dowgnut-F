import 'package:donut_app/models/donutmodel.dart';

class DonutPage {
  final String imgUrl;
  final String logoUrl;
  final List<DonutModel> donuts;

  DonutPage({
    required this.imgUrl,
    required this.logoUrl,
    this.donuts = const [],
  });
}
