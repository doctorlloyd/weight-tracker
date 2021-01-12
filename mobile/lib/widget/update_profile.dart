import 'package:flutter/material.dart';

class WeightUpdate extends StatefulWidget {
  @override
  _WeightUpdate createState() => _WeightUpdate();
}

class _WeightUpdate extends State<WeightUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.black12,
      ),
      // body: ListView.builder(),
    );
  }
}