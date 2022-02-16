import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class CityWeather extends StatelessWidget {
  const CityWeather({
    Key key,
    @required this.pictures,
    @required this.cities,
    @required this.index,
  }) : super(key: key);

  final List<String> pictures;
  final List<String> cities;
  final int index;

  Widget build(BuildContext context) {
    List<List<double>> geolocation = [
      [50.06, 19.94],
      [50.05146, 21.41141],
      [49.74506, 21.47252],
      [53.76474712627604, 20.490128467483242],
    ];
    WeatherFactory wf = new WeatherFactory("4d6bfd3c0aaf505548b49b45d6fa1d61");
    String title = 'Weather in ' + cities[index];
    return FutureBuilder<Weather>(
      future: wf.currentWeatherByLocation(
          geolocation[index][0], geolocation[index][1]),
      builder: (context, AsyncSnapshot<Weather> snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: cities[index],
              home: Scaffold(
                  appBar: AppBar(
                    title: Text(title),
                  ),
                  body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            cities[index],
                            textAlign: TextAlign.center,
                            textScaleFactor: 2,
                          ),
                          Image.network('http://openweathermap.org/img/wn/' +
                              snapshot.data.weatherIcon +
                              '@2x.png'),
                          Text('Temperature: ' +
                              snapshot.data.temperature.celsius.toStringAsFixed(0) +
                              '\nCondition: ' +
                              snapshot.data.weatherDescription +
                              "\nRain last hour: " +
                              snapshot.data.rainLastHour.toString() +
                              "\nSnow last hour: " +
                              snapshot.data.snowLastHour.toString()),
                          ElevatedButton(
                              child: Text('RETURN TO CITY SELECTION'),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ],
                      ))));
        } else {
          return LinearProgressIndicator();
        }
      },
    );
  }
}