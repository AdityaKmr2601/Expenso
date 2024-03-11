import 'package:expenso/bar%20graph/bar_data.dart';
import 'package:expenso/theme/theme_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  const MyBarGraph(
      {super.key,
      this.maxY,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thurAmount,
      required this.friAmount,
      required this.satAmount});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thurAmount: thurAmount,
      friAmount: friAmount,
      satAmount: satAmount,
      sunAmount: sunAmount,
    );
    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
          maxY: maxY,
          minY: 0,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomTitles,
              ))),
          barGroups: myBarData.barData
              .map(
                (data) => BarChartGroupData(
                  x: data.x,
                  barRods: [
                    BarChartRodData(
                        toY: data.y,
                        gradient: LinearGradient(
                            colors: (ThemeProvider().isDarkMode)
                                ? [
                                    Colors.purpleAccent,
                                    Colors.blueAccent,
                                  ]
                                : [
                                    Colors.purpleAccent.shade100,
                                    Colors.blueAccent,
                                  ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                        width: 25,
                        borderRadius: BorderRadius.circular(4),
                        backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: maxY,
                            gradient: LinearGradient(
                                colors: (ThemeProvider().isDarkMode)
                                    ? [Colors.white10, Colors.white12]
                                    : [Colors.black12, Colors.black12],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter))),
                  ],
                ),
              )
              .toList()),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  TextStyle style = TextStyle(
      color: ThemeProvider().themeData.splashColor,
      fontWeight: FontWeight.bold,
      fontSize: 12,
      fontFamily: "Sans");
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text(
        'S',
        style: style,
      );
      break;
    case 1:
      text = Text(
        'M',
        style: style,
      );
      break;
    case 2:
      text = Text(
        'T',
        style: style,
      );
      break;
    case 3:
      text = Text(
        'W',
        style: style,
      );
      break;
    case 4:
      text = Text(
        'T',
        style: style,
      );
      break;
    case 5:
      text = Text(
        'F',
        style: style,
      );
      break;
    case 6:
      text = Text(
        'S',
        style: style,
      );
      break;
    default:
      text = Text(
        '',
        style: style,
      );
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
