import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class ChartWidget extends StatelessWidget {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = Duration(milliseconds: 250);
  final List<int> numbers;
  final List<int> activeElements;
  double wid=double.infinity;


  ChartWidget({this.numbers, this.activeElements});
  @override
  Widget build(BuildContext context) {
    if(wid>400)
      wid=400;
    return Container(
      width: wid,
      height: 250,
      padding: const EdgeInsets.all(16.0),
      child: FlChart(
        swapAnimationDuration: animDuration,
        chart: BarChart(mainBarData()),
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      int y,
      {
        Color barColor = Colors.white,
        double width = 10,
      })
  {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        y: y.toDouble(),
        color: barColor,
        width: width,
        isRound: true,

      ),
    ]);
  }

  List<BarChartGroupData> showingGroups() {
    return numbers.map((f) {
      return makeGroupData(numbers.indexOf(f), f,
          barColor: activeElements.contains(numbers.indexOf(f))
              ? Colors.pink
              : Colors.cyan);
    }).toList();
  }

  BarChartData mainBarData() {
    return BarChartData(

      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 20,
            getTitles: (double value) {
              if (numbers[value.toInt()] == null) {
                return '';
              } else
                return numbers[value.toInt()].toString();
            }),
        leftTitles: SideTitles(
          showTitles:false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}