import 'package:flutter/material.dart';

class WeightList extends StatefulWidget {
  @override
  _WeightList createState() => _WeightList();
}

class _WeightList extends State<WeightList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        title: Text("Day to Day weight"),
        backgroundColor: Colors.black12,
      ),
      // body: ListView.builder(),
    );
  }
}
