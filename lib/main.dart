import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather/repositories/repositories.dart';

import 'blocs/blocs.dart';
import 'widgets/widgets.dart';

class WeatherBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    // TODO: implement onEvent
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    // TODO: implement onError
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  BlocSupervisor.delegate = WeatherBlocDelegate();

  final weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    )
  );

  runApp(WeatherApp(weatherRepository: weatherRepository,));
}

class WeatherApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  WeatherApp({Key key, @required this.weatherRepository})
    : assert(weatherRepository != null),
      super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather",
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: Weather(),
      ),
    );
  }
}