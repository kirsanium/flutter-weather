import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/blocs/weather_event.dart';
import 'package:weather/blocs/weather_state.dart';
import 'package:weather/repositories/repositories.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
    : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      }
      catch (_) {
        yield WeatherError();
      }
    }
  }
}