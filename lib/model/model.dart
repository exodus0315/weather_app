import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Model {
  Widget? getWeatherIcon(int condition) {
    if (condition < 300) {
      return SvgPicture.asset(
        'svg/climacon-cloud-lightning.svg',
        color: Colors.black87,
      );
    } else if (condition < 500) {
      return const Icon(
        Icons.umbrella,
        color: Colors.white,
        size: 70,
      );
    } else if (condition < 600) {
      return const Icon(
        Icons.cloudy_snowing,
        color: Colors.white,
        size: 70,
      );
    } else if (condition < 800) {
      return const Icon(
        Icons.foggy,
        color: Colors.white,
        size: 70,
      );
    } else if (condition == 800) {
      return const Icon(
        Icons.sunny,
        color: Colors.white,
        size: 70,
      );
    } else if (condition <= 804) {
      return const Icon(
        Icons.cloud,
        color: Colors.white,
        size: 30,
      );
    }
  }

  Widget? getAirIcon(int index) {
    if (index == 1) {
      return const Icon(
        Icons.mood,
        size: 35,
        color: Colors.white,
      );
    } else if (index == 2) {
      return const Icon(
        Icons.sentiment_satisfied,
        size: 35,
        color: Colors.white,
      );
    } else if (index == 3) {
      return const Icon(
        Icons.sentiment_neutral,
        size: 35,
        color: Colors.white,
      );
    } else if (index == 4) {
      return const Icon(
        Icons.sentiment_very_dissatisfied,
        size: 35,
        color: Colors.white,
      );
    } else if (index == 5) {
      return const Icon(
        Icons.sick,
        size: 35,
        color: Colors.white,
      );
    }
  }

  Widget? getAirCondition(int index) {
    if (index == 1) {
      return const Text('매우좋음',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ));
    } else if (index == 2) {
      return const Text(
        '좋음',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 3) {
      return const Text(
        '보통',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 4) {
      return const Text(
        '나쁨',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 5) {
      return const Text(
        '매우나쁨',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
