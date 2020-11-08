import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sorting_algorithm_visualiser/all_sorting.dart';


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

class algoDetails{

 static List<Widget> details=[
   ListView(
     //scrollDirection:Axis.vertical,
     children: [
       Text('Bubble Sort',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2,),
       Text('Bubble Sort is the simplest sorting algorithm that works by repeatedly swapping the adjacent elements if they are in wrong order.',
         style: TextStyle(fontSize: 16),),
       SizedBox(height: 10,),
       Text('Complexity',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2),
       SizedBox(height: 20,),
       Text('Time: Worst-O(n^2) Average-O(n^2) Best-O(n)\nSpace: O(1)',style: TextStyle(fontSize: 16),),
       SizedBox(height: 20,),
       Text('Code',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2),
       Image.asset('assets/bubblesort.PNG',width: double.infinity,fit: BoxFit.cover,)
     ],
   ),

   ListView(
     children: [
       Text('Insertion Sort',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2,),
       Text('Insertion sort is a simple sorting algorithm that works similar to the way you sort playing cards in your hands. The array is virtually split into a sorted and an unsorted part. Values from the unsorted part are picked and placed at the correct position in the sorted part.',
         style: TextStyle(fontSize: 16),),
       SizedBox(height: 10,),
       Text('Complexity',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2),
       SizedBox(height: 20,),
       Text('Time: Worst: O(n^2) Best: O(n)',style: TextStyle(fontSize: 16),),
       SizedBox(height: 20,),
       Text('Code',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2),
       Image.asset('assets/insertionsort.PNG',fit: BoxFit.fitWidth,)
     ],
   ),


   ListView(
     children: [
       Text('Selection Sort',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2,),
       Text('The selection sort algorithm sorts an array by repeatedly finding the minimum element (considering ascending order) from unsorted part and putting it at the beginning. ',
         style: TextStyle(fontSize: 16),),
       SizedBox(height: 10,),
       Text('Complexity',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2),
       SizedBox(height: 20,),
       Text('Time: Worst-O(n^2) Average-O(n^2) Best-O(n^2)\nSpace: O(1)',style: TextStyle(fontSize: 16),),
       SizedBox(height: 20,),
       Text('Code',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2),
       Image.asset('assets/selectionsort.PNG')
     ],
   ),


   ListView(
     children: [
       Text('Quick Sort',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2,),
       Text('QuickSort is a Divide and Conquer algorithm. It picks an element as pivot and partitions the given array around the picked pivot. There are many different versions of quickSort that pick pivot in different ways.',
         style: TextStyle(fontSize: 16),),
       SizedBox(height: 10,),
       Text('Complexity',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2),
       SizedBox(height: 20,),
       Text('Time: Worst-O(n^2) Average-O(n*log(n)) Best-O(n*log(n))',style: TextStyle(fontSize: 16),),
       SizedBox(height: 20,),
       Text('Code',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2),
       Image.asset('assets/quicksort.PNG')
     ],
   ),


   ListView(
     children: [
       Text('Heap Sort',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2,),
       Text('Heap sort is a comparison based sorting technique based on Binary Heap data structure. It is similar to selection sort where we first find the maximum element and place the maximum element at the end. We repeat the same process for the remaining elements.',
         style: TextStyle(fontSize: 16),),
       SizedBox(height: 10,),
       Text('Complexity',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.grey,thickness: 2),
       SizedBox(height: 20,),
       Text('Time: Worst-O(n*log(n)) Average-O(n*log(n)) Best-O(n*log(n))',style: TextStyle(fontSize: 16),),
       SizedBox(height: 20,),
       Text('Code',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
       Divider(color: Colors.white,thickness: 2),
       Image.asset('assets/heapsort.PNG')
     ],
   ),

 ];
}

