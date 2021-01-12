class Address {
  int addressId;
  String addressDescription;
  String addressLat;
  String addressLon;

  Address(
      {this.addressId,
        this.addressDescription,
        this.addressLat,
        this.addressLon});

  Address.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    addressDescription = json['address_description'];
    addressLat = json['address_lat'];
    addressLon = json['address_lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['address_description'] = this.addressDescription;
    data['address_lat'] = this.addressLat;
    data['address_lon'] = this.addressLon;
    return data;
  }
}