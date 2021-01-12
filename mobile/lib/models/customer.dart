import 'address.dart';

class Customer {
  String gender;
  int user;
  String dateOfBirth;
  Address address;
  String imageurl;

  Customer(
      {this.gender, this.user, this.dateOfBirth, this.address, this.imageurl});

  Customer.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    user = json['user'];
    dateOfBirth = json['date_of_birth'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    imageurl = json['imageurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['user'] = this.user;
    data['date_of_birth'] = this.dateOfBirth;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['imageurl'] = this.imageurl;
    return data;
  }
}