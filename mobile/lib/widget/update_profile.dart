import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/models/customer.dart';
import 'package:mobile/rest/data_file.dart';

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
        title: Text("Profile"),
        backgroundColor: Colors.black12,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
          ),
        ),
        child: FutureBuilder(
          future: getCustomer(context),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return Scaffold(
                //TODO populate profile
              );
            else if (snapshot.connectionState.toString() ==
                'ConnectionState.done')
              return Center(
                child: Text('No Data Was Found'),
              );
            else
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.greenAccent,
                  strokeWidth: 1,
                ),
              );
          },
        ),
      ),
    );
  }

  Future<Customer> getCustomer(BuildContext context) async {
    return await api.profile();
  }
}