import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sorting_algorithm_visualiser/insertion_sort.dart';
import 'bubble_sort.dart';

class SortingDetails extends StatefulWidget {
  @override
  _SortingDetailsState createState() => _SortingDetailsState();
}

class _SortingDetailsState extends State<SortingDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(title: Text('Sorting Algorithm'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 15,
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.pinkAccent),
          onTap: (index){},
          tabs: [
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text("Bubble",style: TextStyle(fontSize: 12),),
              ),
            ),
            Tab(child: Text('Insertion',style: TextStyle(fontSize: 10,),),),
            Tab(child: Text('Selection',style: TextStyle(fontSize: 9),),),
            Tab(child: Text('Quick',style: TextStyle(fontSize: 10,)),),
            Tab(child: Text('Heap',style: TextStyle(fontSize: 10,)),)
          ],
        ),
        ),
        body: TabBarView(
          children: [
            BubbleSort(),
            InsertionSort(),
            Text('SelectionSort'),
            Text('Quicksort'),
            Text('Quicksort')
          ],
        ),
      ),
    );
  }
}
