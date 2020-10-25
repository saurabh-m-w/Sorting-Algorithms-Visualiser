import 'package:flutter/material.dart';
import 'constant.dart';
class BubbleSort extends StatefulWidget {
  @override
  _BubbleSortState createState() => _BubbleSortState();
}

class _BubbleSortState extends State<BubbleSort> {
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


  void bubblesort() async{
    setState(() {
      isSorting=true;
    });
    for(int i=0;i<n-1;i++){
      if(iscancelled) break;
        for(int j=0;j<n-i-1;j++){
          if(iscancelled) break;
              updatePointers([j,j+1]);
              updateMessage("is "+numbers[j].toString()+" > "+numbers[(j+1)].toString()+" ?");
              await Future.delayed(Duration(milliseconds: 3000-delay.toInt()));
                if(numbers[j]>numbers[j+1]){
                  int temp=numbers[j];
                  numbers[j]=numbers[j+1];
                  numbers[j+1]=temp;
                  updateMessage("Yes, so Swap "+numbers[j].toString()+" & "+numbers[(j+1)].toString());
                }
                else{
                  updateMessage("No,so no Swapping");
                }

                await Future.delayed(Duration(milliseconds: 3000-delay.toInt()));
        }
    }
    if(iscancelled==false) updateMessage("Sorted");
    else updateMessage("Cancelled");
    setState(() {
      iscancelled=false;
      isSorting=false;
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
            });}: (){bubblesort();},
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

