import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/blocs.dart';
import 'package:weather/widgets/widgets.dart';

class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon (Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                )
              );

              if (city != null) {
                BlocProvider.of<WeatherBloc>(context)
                  .add(FetchWeather(city: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherEmpty) {
              return Center(
                child: Text('Choose the city'),
              );
            }
            if (state is WeatherLoading) {
              return CircularProgressIndicator();
            }
            if (state is WeatherLoaded) {
              final weather = state.weather;

              return ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Center(
                      child: Location(location: weather.location),
                    ),
                  ),
                  Center(
                    child: LastUpdated(dateTime: weather.lastUpdated),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: Center(
                      child: CombinedWeatherTemperature(
                        weather: weather
                      ),
                    ),
                  )
                ],
              );
            }
            if (state is WeatherError) {
              return Center(
                child: Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.red),                
                ),
              );
            }
          },
        ),
      ),
    );
  }
}