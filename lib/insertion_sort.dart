import 'package:flutter/material.dart';
import 'package:sorting_algorithm_visualiser/constant.dart';

class InsertionSort extends StatefulWidget {
  @override
  _InsertionSortState createState() => _InsertionSortState();
}

class _InsertionSortState extends State<InsertionSort> {
  List<int> numbers=[10,58,35,65,29,18,25,69];
  List<int> pointers=[];
  String message="";
  bool isSorting=false,iscancelled=false;
  int n=8;
  double delay=2000,wid=double.infinity;
  @override
  Widget build(BuildContext context) {
    if(wid>400)
      wid=420;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ChartWidget(
              numbers: numbers,
              activeElements: pointers,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                'Speed',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: wid,
              child: Slider(
                activeColor: Colors.pinkAccent,
                label: 'Speed',
                min:200,
                max:3000,
                value: delay.toDouble(),
                onChanged: (double val){
                  setState(() {
                    delay=val;
                  });
                },
              ),
            ),

            bottombuttons()
          ],
        ),
      ),
    );
  }

  void updatePointers(List<int> currpointers){
    setState(() {
      pointers=currpointers;
    });
  }
  void updateMessage(String s){
    setState(() {
      message=s;
    });
  }


  void insertionSort() async {
    setState(() {
      isSorting = true;
    });
    for (int i = 1; i < n; i++)
    {
      if (iscancelled) break;
      int j, key;
      key = numbers[i];
      j = i - 1;
      updatePointers([i]);
      await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
      while (j >= 0 && numbers[j] > key)
      {
          await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
          updatePointers([numbers.indexOf(key), j]);
          if (iscancelled) break;
          int temp=numbers[j+1];
          numbers[j + 1] = numbers[j];
          numbers[j]=temp;
          j--;
      }
      numbers[j + 1] = key;
    }
    if (iscancelled == false)
      updateMessage("Sorted");
    else
      updateMessage("Cancelled");
    setState(() {
      iscancelled = false;
      isSorting = false;
    });
  }


  Widget bottombuttons(){
    return  Padding(
      padding: const EdgeInsets.only(bottom:16.0,top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton.extended(
            icon: isSorting?Icon(Icons.stop):Icon(Icons.sort),
            onPressed: isSorting?(){setState(() {
              iscancelled=true;
            });}: (){insertionSort();},
            label: isSorting?Text('Stop'):Text('Sort'),

          ),
          FloatingActionButton.extended(
            tooltip: 'Shuffle',
            backgroundColor: isSorting?Colors.grey:Colors.blue,
            icon: Icon(Icons.shuffle),
            onPressed: isSorting?null:(){
              setState(() {
                numbers.shuffle();
              });
            },
            label: Text('Shuffle'),
          ),
        ],
      ),
    );
  }

}
