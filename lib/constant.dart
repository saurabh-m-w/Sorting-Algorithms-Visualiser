import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class ChartWidget extends StatelessWidget {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = Duration(milliseconds: 250);
  final List<int> numbers;
  final List<int> activeElements;
  bool isdesktop=false;
  int len;
  double desktopWidth=400;

  ChartWidget({this.numbers, this.activeElements});
  @override
  Widget build(BuildContext context) {
    len=numbers.length;
    double wid = MediaQuery. of(context). size. width;
    if(wid>500) {
      isdesktop = true;
    }
    if(isdesktop && len>8 && len<=11)
      desktopWidth=500;
    else if(isdesktop && len>=12 && len<=15)
      desktopWidth=600;
    else if(isdesktop && len>=16 && len<=20 && 700<=wid)
      desktopWidth=700;
    else if(isdesktop && len>=21 && len<=26 && 800<=wid)
      desktopWidth=800;
    else if(isdesktop && len>=27)
      desktopWidth=wid;

    return Container(
      width: isdesktop?desktopWidth:wid,
      height: 250,
      padding: const EdgeInsets.all(16.0),
      child: FlChart(
        swapAnimationDuration: animDuration,
        chart: BarChart(mainBarData()),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, int y, {Color barColor = Colors.white, double width = 10,})
  {
    return BarChartGroupData(x: x, barRods: [ BarChartRodData(y: y.toDouble(), color: barColor, width: isdesktop?20:width, isRound: true),]);
  }



  BarChartData mainBarData() {
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 20,
            getTitles: (double value) {
              if (numbers[value.toInt()] == null) {
                return '';
              } else
                return numbers[value.toInt()].toString();
            }),
        leftTitles: SideTitles(showTitles:false,),
      ),
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(),
    );
  }
  List<BarChartGroupData> showingGroups() {
    return numbers.map((f) {
      return makeGroupData(numbers.indexOf(f), f,
          barColor: activeElements.contains(numbers.indexOf(f))? Colors.pink : Colors.cyan);
    }).toList();
  }
}