import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:weather_app/model/model.dart';
import 'package:weather_app/screens/loading.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData, this.parseAirPollution});
  final dynamic parseWeatherData;
  final dynamic parseAirPollution;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  late String cityName;
  late int temp;
  late int condition;
  late Widget icon;
  late String desc;
  late Widget airIcon;
  late Widget airState;
  late double dust1;
  late double dust2;

  var date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollution);
  }

  void updateData(dynamic weatherData, dynamic airData) {
    int index = airData['list'][0]['main']['aqi'];
    airIcon = model.getAirIcon(index)!;
    airState = model.getAirCondition(index)!;
    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];
    cityName = weatherData['name'];
    condition = weatherData['weather'][0]['id'];
    desc = weatherData['weather'][0]['description'];
    icon = model.getWeatherIcon(condition)!;
    double temp2 = weatherData['main']['temp'];

    temp = temp2.round();

    print('cityName: $cityName, temp: $temp');
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true, // Title 중앙 정렬
        title: Text('$cityName'),
        backgroundColor: Colors.transparent, // appBar 투명
        elevation: 0, // appBar 그림자 제거
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Loading()),
              );
            },
            icon: const Icon(Icons.location_searching),
            iconSize: 30,
          ), // 오른쪽 아이콘
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 150,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$temp\u2103',
                          style: GoogleFonts.lato(
                            fontSize: 100,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            icon,
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              '$desc',
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  const Divider(
                    height: 15,
                    thickness: 2,
                    color: Colors.white30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'AQI(대기질지수)',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          airIcon,
                          const SizedBox(
                            height: 10,
                          ),
                          airState,
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '미세먼지',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '$dust1',
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'ug/m3',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '초미세먼지',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '$dust2',
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'ug/m3',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                height: 15,
                thickness: 2,
                color: Colors.white30,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                // 시간 표현
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('yyyy-MM-dd (EE)  ').format(date),
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  TimerBuilder.periodic(
                    (Duration(minutes: 1)),
                    builder: (context) {
                      return Text(
                        '${getSystemTime()}',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
