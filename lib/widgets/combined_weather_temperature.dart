import 'package:flutter/material.dart';
import 'package:weather/models/models.dart'as model;

import 'widgets.dart';

class CombinedWeatherTemperature extends StatelessWidget {
  final model.Weather weather;

  CombinedWeatherTemperature({Key key, this.weather})
  : assert(weather != null),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: WeatherConditions(weatherCondition : weather.condition),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Temperature(
                temperature: weather.temp,
                high: weather.maxTemp,
                low: weather.minTemp
              ),
            )
          ],
        ),
        Center(
          child: Text(
            weather.formattedCondition,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              color: Colors.white
            ),
          ),
        )
      ],
    );
  }
}