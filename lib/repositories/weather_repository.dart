import 'package:meta/meta.dart';
import 'package:weather/models/models.dart';
import 'package:weather/repositories/weather_api_client.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
    : assert(weatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    final Weather weather = await weatherApiClient.fetchWeather(locationId);

    return weather;
  }
}