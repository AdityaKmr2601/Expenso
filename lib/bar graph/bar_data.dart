import 'package:expenso/bar%20graph/individual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(y: sunAmount, x: 0),
      IndividualBar(y: monAmount, x: 1),
      IndividualBar(y: tueAmount, x: 2),
      IndividualBar(y: wedAmount, x: 3),
      IndividualBar(y: thurAmount, x: 4),
      IndividualBar(y: friAmount, x: 5),
      IndividualBar(y: satAmount, x: 6),
    ];
  }
}
