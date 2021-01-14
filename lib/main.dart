import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:weather/weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Most wanted weather conditions';
    final List<String> pictures = <String>[
      'images/krakow.jpg',
      'images/debica.jpg',
      'images/jaslo.jpg'
    ];
    final List<String> cities = <String>['Kraków', 'Dębica', 'Jasło'];
    final List<int> colorCodes = <int>[600, 500, 100];
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: CitiesList(
            pictures: pictures, colorCodes: colorCodes, cities: cities),
      ),
    );
  }
}

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
      [49.74506, 21.47252]
    ];
    WeatherFactory wf = new WeatherFactory("4d6bfd3c0aaf505548b49b45d6fa1d61");
    String title = 'Weather in ' + cities[index];
    return FutureBuilder<Weather>(
      future: wf.currentWeatherByLocation(
          geolocation[index][0], geolocation[index][1]),
      builder: (context, AsyncSnapshot<Weather> snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
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
                          snapshot.data.temperature.celsius
                              .toStringAsPrecision(1) +
                          '\nCondition: ' +
                          snapshot.data.weatherDescription +
                          "\nRain last hour: " +
                          snapshot.data.rainLastHour.toString() +
                          "\nSnow last hour: " +
                          snapshot.data.snowLastHour.toString()),
                      ElevatedButton(
                          child: Text('RETURN TO MAIN PAGE'),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ))));
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class CitiesList extends StatelessWidget {
  const CitiesList({
    Key key,
    @required this.pictures,
    @required this.colorCodes,
    @required this.cities,
  }) : super(key: key);

  final List<String> pictures;
  final List<int> colorCodes;
  final List<String> cities;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: pictures.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CityWeather(
                      pictures: pictures, cities: cities, index: index)),
            );
          },
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  color: Colors.amber[colorCodes[index]],
                  child: Image.asset(
                    pictures[index],
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    cities[index],
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        backgroundColor: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
