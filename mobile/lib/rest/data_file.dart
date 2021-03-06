import 'dart:convert';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/models/customer.dart';
import 'package:mobile/models/token.dart';
import 'package:mobile/models/weight.dart';
import 'package:mobile/utils/network.dart';
import 'package:http/http.dart' as http;

class RestDataSource {
  NetworkUtil netUtil = new NetworkUtil();
  final LocalStorage storage = new LocalStorage('weightTrackerDB');
  static final domain = 'http://192.168.0.145:8000';
  static final baseUrl = "$domain/api";

  String conservationID;
  String tokenDecoded;
  String apiKey;

  Map<String, String> defaultHeaders() =>
      <String, String>{'Accept': 'application/json'};

  Future<Token> login(String username, String password) async {
    final login = baseUrl + '-token-auth/';
    return await netUtil.post(login,
        headers: defaultHeaders(),
        body: {'username': username, 'password': password}).then((dynamic res) {
      return Token.fromJson(res);
    });
  }

  Future<Customer> profile() async {
    final profile = baseUrl + '/customer/';
    Response _response = await get(profile, headers: requestHeaders());
    Map<String, dynamic> map = jsonDecode(_response.body);
    return Customer.fromJson(map);
  }

  Future<List<Weight>> getWeightList(String param) async {
    var apiUrl = baseUrl + '/weight/?customer=$param';
    http.Response products = await http.get(apiUrl, headers: requestHeaders());
    List<dynamic> productList = json.decode(products.body);
    return productList.map((i) => Weight.fromJson(i)).toList();
  }

  Future<Token> register(String username, String password, String email) async {
    final login = baseUrl + '/register/customer/';
    return await netUtil.post(
      login,
      headers: defaultHeaders(),
      body: {'username': username, 'password': password, 'email': email},
    ).then(
      (dynamic res) {
        return Token.fromJson(res);
      },
    );
  }

  Future<Response> addWeight(String weight, String customer) async {
    final weighturl = baseUrl + '/addweight/';
    http.Response response = await http.post(weighturl,
        body: {'weight': weight, 'customer': customer}, headers: requestHeaders());
    return response;
  }

  Future<Response> putWeight(String weight, String weightId, String customer) async {
    final weighturl = baseUrl + '/addweight/';
    http.Response response = await http.put(weighturl,
        body: {'weight': weight, 'weight_id': weightId, 'customer':customer}, headers: requestHeaders());
    return response;
  }

  Future<Response> deleteWeight(Weight weight) async {
    final weighturl = baseUrl + '/addweight/?weightId=${weight.weightId}';
    http.Response response = await http.delete(weighturl,
        headers: requestHeaders());
    return response;
  }

  //Token returned during login
  String getToken() {
    Map<String, dynamic> token = this.storage.getItem('token');
    return token['token'];
  }

  //Setting headers to include on requests (API calls)
  Map<String, String> requestHeaders() => <String, String>{
        'Accept': 'application/json',
        'Authorization': 'JWT ' + getToken(),
      };
//End block
}
