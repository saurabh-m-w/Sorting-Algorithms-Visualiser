import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sorting_algorithm_visualiser/all_sorting.dart';

class SortingDetails extends StatefulWidget {
  @override
  _SortingDetailsState createState() => _SortingDetailsState();
}

class _SortingDetailsState extends State<SortingDetails> {
    bool isdesktop=false;
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery. of(context). size. width;
    if(wid>500)
      isdesktop=true;
    return Scaffold(
      appBar: AppBar(title: isdesktop?Text('Sorting Algorithms',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),):Text('Sorting Algorithms'),
        toolbarHeight: isdesktop?50:60,
      centerTitle: true,
      backgroundColor: isdesktop?Colors.black12:Colors.blueAccent,
      elevation: 5,
      ),
      body: SortingAlgo(),
    );
  }
}
