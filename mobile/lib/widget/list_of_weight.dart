import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/models/customer.dart';
import 'package:mobile/models/weight.dart';
import 'package:mobile/rest/data_file.dart';

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
        title: Text("Day to Day weight"),
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

        // return Dismissible(
        //   key: Key(item.weight),
        //   onDismissed: (direction) {
        //     setState(
        //       () {
        //         weightList.removeAt(index);
        //       },
        //     );
        //   },
        //   background: Container(color: Colors.red),
        //   child: ListTile(
        //     title: Text('${item.weight}'),
        //   ),
        // );
        return Card(
          elevation: 4,
          shadowColor: Colors.greenAccent,
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  //TODO edit
                },
                onLongPress: (){
                  //TODO delete
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Date: ${item.dateEntered}'),
                    Text('Weight: ${item.weight}'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
