import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    fetchData();
  }

  void getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position);
    } catch (e) {
      print('Connection Error');
    }
  }

  void fetchData() async {
    Response response = await get(Uri.parse(
        'https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var weatherCityId = jsonDecode(jsonData)['id'];
      var weatherCity = jsonDecode(jsonData)['name'];
      var weatherDescription =
          jsonDecode(jsonData)['weather'][0]['description'];
      var weatherWindSpeed = jsonDecode(jsonData)['wind']['speed'];
      print('weatherCityId : $weatherCityId');
      print('weatherCity : $weatherCity');
      print('weatherDescription : $weatherDescription');
      print('Wind Speed : $weatherWindSpeed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: null,
          child: Text(
            'Get my Location',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
        ),
      ),
    );
  }
}
