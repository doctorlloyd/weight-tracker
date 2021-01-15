import 'package:mobile/models/customer.dart';

class Weight {
  int weightId;
  String weight;
  Customer customer;
  String dateEntered;

  Weight({this.weightId, this.weight, this.customer, this.dateEntered});

  Weight.fromJson(Map<String, dynamic> json) {
    weightId = json['weight_id'];
    weight = json['weight'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    dateEntered = json['date_entered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weight_id'] = this.weightId;
    data['weight'] = this.weight;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    data['date_entered'] = this.dateEntered;
    return data;
  }
}