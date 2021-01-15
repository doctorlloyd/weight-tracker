import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/models/customer.dart';
import 'package:mobile/models/token.dart';
import 'package:mobile/rest/data_file.dart';

class Weight extends StatefulWidget {
  @override
  _Weight createState() => _Weight();
}

class _Weight extends State<Weight> {
  TextEditingController enteredWeightController = TextEditingController();
  RestDataSource _restDataSource;
  bool _isLoading = false;
  final LocalStorage storage = new LocalStorage('weightTrackerDB');
  Map<String, dynamic> user;
  Customer customer;

  @override
  void initState() {
    super.initState();
    _restDataSource = RestDataSource();
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
        title: Text("Enter weight"),
        backgroundColor: Colors.black12,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 20.0),
                      child: new Text(
                        "Enter your weight.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 40.0, right: 40.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.black,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextField(
                        controller: enteredWeightController,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Weight in kg(s).',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      shape: StadiumBorder(),
                      color: Colors.deepOrangeAccent[100],
                      textColor: Colors.white,
                      onPressed: () {
                        addWeight();
                      },
                      child: Text('Submit your weight',
                          style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addWeight() async {
    if (enteredWeightController.text.isNotEmpty) {
      Response response = await _restDataSource.addWeight(
          enteredWeightController.text, customer.user.toString());
      if (response.body == '1') {
        enteredWeightController.clear();
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }
}
