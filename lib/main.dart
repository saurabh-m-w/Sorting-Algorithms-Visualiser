import 'package:flutter/material.dart';
import 'package:sorting_algorithm_visualiser/sortingDetails.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData.dark(),
      home: SortingDetails(),
    );
  }
}
