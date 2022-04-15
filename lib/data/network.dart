import 'package:http/http.dart';
import 'dart:convert';

class Network {
  final String url;
  final String url2;
  Network(this.url, this.url2);

  Future<dynamic> getJsonData() async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    } else {
      print('Network Connection Error');
    }
  }

  Future<dynamic> getAirData() async {
    Response response = await get(Uri.parse(url2));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    } else {
      print('Network Connection Error');
    }
  }
}
