import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/models/customer.dart';
import 'package:mobile/models/weight.dart';
import 'package:mobile/rest/data_file.dart';
import 'package:mobile/widget/update_weight.dart';
import 'package:toast/toast.dart';

class WeightList extends StatefulWidget {
  @override
  _WeightList createState() => _WeightList();
}

class _WeightList extends State<WeightList> {
  RestDataSource api;
  final LocalStorage storage = new LocalStorage('weightTrackerDB');
  Map<String, dynamic> user;
  Customer customer;
  List<Weight> weightList = List<Weight>();

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
        title: Text("Day to Day weight"),
        backgroundColor: Colors.black12,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        child: FutureBuilder(
          future: getWeightList(context),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return listView();
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

  Future<List<Weight>> getWeightList(BuildContext context) async {
    weightList.clear();
    weightList = await api.getWeightList(customer.user.toString());
    return weightList;
  }

  Widget listView() {
    return ListView.builder(
      itemCount: weightList.length,
      itemBuilder: (context, index) {
        final item = weightList[index];
        return card(item);
      },
    );
  }

  Widget card(Weight weight) {
    return Card(
      elevation: 8,
      shadowColor: Colors.greenAccent,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return UpdateWeight(weight);
                  },
                ),
              );
            },
            onLongPress: () {
              delete(weight, context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Date: ${weight.dateEntered}'),
                Text('Weight: ${weight.weight}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete(Weight weight, BuildContext context) async {
    Response response = await api.deleteWeight(weight);
    if (response.statusCode == 200) {
      Toast.show("Weight object deleted: ${weight.weight}", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      setState(() {
        getWeightList(context);
      });
    }
  }
}
