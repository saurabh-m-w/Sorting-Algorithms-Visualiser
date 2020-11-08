

import 'package:flutter/material.dart';
import 'package:sorting_algorithm_visualiser/constant.dart';

class SortingAlgo extends StatefulWidget {
  @override
  _SortingAlgoState createState() => _SortingAlgoState();
}

class _SortingAlgoState extends State<SortingAlgo> {
  List<int> numbers = [10, 58, 35, 65, 29, 18, 25, 69];
  List<int> pointers = [];
  String message = "";
  bool isSorting = false,
      iscancelled = false,
      isdesktop = false;
  int n = 8;
  double delay = 2000,
      wid = double.infinity;
  int isselected = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery
        .of(context)
        .size
        .width;
    if (wid > 500) {
      isdesktop = true;
      wid = 420;
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black12,
      drawerScrimColor: Colors.transparent,
      endDrawer: Container(height: 550,width: 300,color: Colors.white,child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: algoDetails.details[isselected-1],
      ),),

      body: Container(
        height:double.infinity,
        child: Column(
          //direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            isdesktop ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getList(),
            ) : Container(),
            //isdesktop?Container():Row(mainAxisAlignment:MainAxisAlignment.center,children: [Text('Bubble Sort',style: TextStyle(fontSize:25,fontWeight: FontWeight.bold),),SizedBox(width: 10,),GestureDetector(child: Text('Change'),onTap: (){showBottomSheet(context);},)],),
            isdesktop ? Container() : Container(margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(0),
                height: 60,
                child: ListView(scrollDirection: Axis.horizontal,
                    children: getList(),
                    physics: ScrollPhysics().parent)),

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Sort Speed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap:(){ isdesktop?_scaffoldKey.currentState.openEndDrawer():showBottomSheet1();},
                  child: Text(
                    'More Info',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            Container(

              width: wid,
              child: Slider(
                activeColor: Colors.pinkAccent,
                label: 'Speed',
                min: 200,
                max: 3000,
                value: delay.toDouble(),
                onChanged: (double val) {
                  setState(() {
                    delay = val;
                  });
                },
              ),
            ),

             bottombuttons(),

          ],
        ),
      ),
    );
  }

  void updatePointers(List<int> currpointers) {
    setState(() {
      pointers = currpointers;
    });
  }

  void updateMessage(String s) {
    setState(() {
      message = s;
    });
  }

//-----------------------Bubble Sort-------------------------------------
  void bubblesort() async {
    setState(() {
      isSorting = true;
    });
    for (int i = 0; i < n - 1; i++) {
      if (iscancelled) break;
      for (int j = 0; j < n - i - 1; j++) {
        if (iscancelled) break;
        updatePointers([j, j + 1]);
        updateMessage("is " + numbers[j].toString() + " > " +
            numbers[(j + 1)].toString() + " ?");
        await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
        if (numbers[j] > numbers[j + 1]) {
          int temp = numbers[j];
          numbers[j] = numbers[j + 1];
          numbers[j + 1] = temp;
          updateMessage("Yes, so Swap " + numbers[j].toString() + " & " +
              numbers[(j + 1)].toString());
        }
        else {
          updateMessage("No,so no Swapping");
        }

        await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
      }
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
//-------------------------Selection Sort------------------------------
  void selectionsort() async {
    setState(() {
      isSorting = true;
    });
    // One by one move boundary of unsorted subnumbersay
    for (int i = 0; i < n - 1; i++) {
      if (iscancelled) break;
      // Find the minimum element in unsorted numbersay
      int minIdx = i;
      updateMessage('Finding minimum');
      for (int j = i + 1; j < n; j++) {
        if (iscancelled) break;
        updatePointers([i, j]);
        await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
        if (numbers[j] < numbers[minIdx]) minIdx = j;
      }

      // Swap the found minimum element with the first element
      updatePointers([minIdx, i]);
      updateMessage('Swapping minimum element ${numbers[minIdx]} and ${numbers[i]}');
      await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
      int temp=numbers[i];
      numbers[i]=numbers[minIdx];
      numbers[minIdx]=temp;

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
//-------------------------Insertion Sort------------------------------
  void insertionSort() async {
    setState(() {
      isSorting = true;
    });
    updatePointers([0]);
    updateMessage('Assume first element to be already sorted');
    await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
    for (int i = 1; i < n; i++) {
      if (iscancelled) break;
      int j, key;
      key = numbers[i];
      j = i - 1;
      updatePointers([i]);
      updateMessage('Taking ${numbers[i]} as key element.');
      await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
      while (j >= 0 && numbers[j] > key) {
        if (iscancelled) break;
        updatePointers([numbers.indexOf(key), j]);
        updateMessage('Since $key < ${numbers[j]} so, inserting it one place before.');
        await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
        int temp = numbers[j + 1];
        numbers[j + 1] = numbers[j];
        numbers[j] = temp;
        j--;
        updatePointers([numbers.indexOf(key)]);
        await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
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

//-----------------------Heap Sort-----------------------------------
  void heapify(List<int> numbers, int n, int i) async {
    updateMessage("adjusting heap");
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;
    //updatePointers([l,r]);
    //await Future.delayed(Duration(milliseconds: 3000-delay.toInt()));
    if (l < n && numbers[l] > numbers[largest])
      largest = l;
    if (r < n && numbers[r] > numbers[largest])
      largest = r;

    if (largest != i) {
      //updatePointers([largest,i]);
      int temp = numbers[i];
      numbers[i] = numbers[largest];
      numbers[largest] = temp;

     await heapify(numbers, n, largest);
    }
  }
  void heapsort() async {
    setState(() {
      isSorting = true;
    });

    for (int i = n ~/ 2 - 1; i >= 0; i--) {
      await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
      if (iscancelled) break;
      updateMessage("building heap");
      heapify(numbers, n, i);
    }
    updateMessage("heap builded");
    await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
    updateMessage("now swap ${numbers[0]} & ${numbers[n-1]}");
    updatePointers([0, n - 1]);
    for (int i = n - 1; i >= 0; i--) {
      // Move current root to end
      await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
      updatePointers([0, i]);
      if (iscancelled) break;
      updateMessage("now swap ${numbers[0]} & ${numbers[i]}");
      await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
      int temp = numbers[0];
      numbers[0] = numbers[i];
      numbers[i] = temp;

      heapify(numbers, i, 0);
    }

    if (iscancelled == false)
      updateMessage("Sorted");
    else
      updateMessage("Cancelled");
    setState(() {
      iscancelled = false;
      isSorting = false;
    });
    print(numbers);
  }


  //---------------------------------------------------------------
  //_____________QuickSort_________________________________
  Future<int> partition(int low,int high)async{
    int pivot=numbers[low];
    int i=low,j=high,temp;
    updatePointers([low]);
    updateMessage("consider ${numbers[low]} pivot");
    await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
    while(i<j){
      if(iscancelled) break;
      while(pivot>=numbers[i] && i<high && !iscancelled)
        i++;
      while(pivot<numbers[j] && j>low &&!iscancelled)
        j--;
      if(i<j){
        temp=numbers[i];
        numbers[i]=numbers[j];
        numbers[j]=temp;
      }
    }
    temp=numbers[low];
    numbers[low]=numbers[j];
    numbers[j]=temp;
    return j;
  }

  void quickSort(int low,int high) async{
    setState(() {
      isSorting = true;
    });

    if(low<high && !iscancelled){
      await Future.delayed(Duration(milliseconds: 3000 - delay.toInt()));
      int pi = await partition(low,high);
      await quickSort(low, pi-1);
      await quickSort(pi+1, high);
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

//----------------------------------------------------------------------------------
  Widget bottombuttons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton.extended(
            icon: isSorting ? Icon(Icons.stop) : Icon(Icons.sort),
            onPressed: isSorting ? () {
              setState(() {
                iscancelled = true;
              });
            } : () {
              if (isselected == 1)
                bubblesort();
              else if (isselected == 2)
                insertionSort();
              else if(isselected==3)
                selectionsort();
              else if(isselected==4)
                quickSort(0, n-1);
              else if (isselected == 5)
                heapsort();
            },
            label: isSorting ? Text('Stop') : Text('Sort'),

          ),
          FloatingActionButton.extended(
            elevation: isSorting?0:5,
            icon: Icon(Icons.edit),
            onPressed: isSorting ? null : () {
              getArray();
            },
            label: Text('Edit'),
            backgroundColor: isSorting ? Colors.grey : Colors.blue,
          ),
          FloatingActionButton.extended(
            elevation: isSorting?0:5,
            tooltip: 'Shuffle',
            backgroundColor: isSorting ? Colors.grey : Colors.blue,
            icon: Icon(Icons.shuffle),
            onPressed: isSorting ? null : () {
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

  Future<Widget> getArray() async {
    String arr;
    bool iserr = false;
    String hint = "";
    for (int i = 0; i < n; i++) {
      hint += numbers[i].toString();
      if (i != n - 1) {
        hint += ",";
      }
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              width: isdesktop?400:wid,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Enter new Array'),
                    TextFormField(
                      initialValue: hint,
                      keyboardType: TextInputType.numberWithOptions(),
                      onChanged: (String text) {
                        setState(() {
                          arr = text;
                        });
                      },
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          //hintText: 'Enter new Array',
                          focusColor: Colors.pinkAccent,
                          helperText: 'Enter numbers seperated by ,',
                          helperStyle: TextStyle(
                              color: Colors.black, fontSize: 12)
                      ),
                    ),

                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(

                          onPressed: () {
                            try {
                              List<int> numbers2 = [];
                              final _values = arr.trim().split(',');
                              _values.forEach((element) {
                                numbers2.add(int.parse(element));
                              });
                              setState(() {
                                n = numbers2.length;
                                numbers = numbers2;
                              });
                              Navigator.pop(context);
                            }
                            catch (e) {

                            }
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  List<Widget> getList() {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          elevation: isSorting?0:5,
          backgroundColor: isselected == 1 ? Colors.blue : Colors.grey,
          label: Text('Bubble Sort'),
          onPressed: isSorting ? null : () {
            setState(() {
              isselected = 1;
              message="";
            });
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          elevation: isSorting?0:5,
          backgroundColor: isselected == 2 ? Colors.blue : Colors.grey,
          label: Text('Insertion Sort'),
          onPressed: isSorting ? null : () {
            setState(() {
              isselected = 2;
              message="";
            });
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          elevation: isSorting?0:5,
          backgroundColor: isselected == 3 ? Colors.blue : Colors.grey,
          label: Text('Selection Sort'),
          onPressed: isSorting ? null : () {
            setState(() {
              isselected = 3;
              message="";
            });
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          elevation: isSorting?0:5,
          backgroundColor: isselected == 4 ? Colors.blue : Colors.grey,
          label: Text('Quick Sort'),
          onPressed: isSorting ? null : () {
            setState(() {
              isselected = 4;
              message="";
            });
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          elevation: isSorting?0:5,
          backgroundColor: isselected == 5 ? Colors.blue : Colors.grey,
          label: Text('Heap Sort'),
          onPressed: isSorting ? null : () {
            setState(() {
              isselected = 5;
              message="";
            });
          },
        ),
      ),
    ];
  }
  Future<Widget> showBottomSheet1(){
   return showModalBottomSheet(
    isDismissible: true,
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
     backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 700,
          decoration:BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12))),
          padding: const EdgeInsets.all(8.0),
          child: algoDetails.details[isselected-1],
        );
      },
    );
  }
}
