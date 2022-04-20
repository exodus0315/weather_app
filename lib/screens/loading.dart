import 'package:flutter/material.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'e3e32162e724639657c741e77d4c83b1';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late double myLatitude;
  late double myLongitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    myLatitude = myLocation.latitude2;
    myLongitude = myLocation.longitude2;
    print('myLatitude: $myLatitude, myLongitude: $myLongitude');

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=$myLatitude&lon=$myLongitude&appid=$apiKey&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$myLatitude&lon=$myLongitude&appid=$apiKey');

    var weatherData = await network.getJsonData();
    print('$weatherData');

    var airData = await network.getAirData();
    print('$airData');

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(
        parseWeatherData: weatherData,
        parseAirPollution: airData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'JIN Weather',
              style: TextStyle(
                fontFamily: 'Akshar',
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SpinKitWave(
              color: Colors.white,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
