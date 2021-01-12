import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/models/customer.dart';
import 'package:mobile/rest/data_file.dart';
import 'package:transparent_image/transparent_image.dart';

class WeightUpdate extends StatefulWidget {
  @override
  _WeightUpdate createState() => _WeightUpdate();
}

class _WeightUpdate extends State<WeightUpdate> {
  RestDataSource api;
  final LocalStorage storage = new LocalStorage('weightTrackerDB');
  Map<String, dynamic> user;
  Customer customer;

  @override
  void initState() {
    super.initState();
    api = RestDataSource();
    user = storage.getItem('current_user');
    customer = Customer.fromJson(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
        title: Text("Profile"),
        backgroundColor: Colors.black12,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 32.0, left: 18, right: 16),
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: customer.imageurl,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
