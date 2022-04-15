import 'package:flutter/material.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';

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

  // void fetchData() async {
  //     var weatherCityId = parsingData['id'];
  //     var weatherDescription = parsingData['weather'][0]['description'];
  //     print('weatherCityId : $weatherCityId');
  //     print('weatherDescription : $weatherDescription');
  //   } else {
  //     print(response.statusCode);
  //   }
  // }

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
