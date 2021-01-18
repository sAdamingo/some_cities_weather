import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:weather/weather.dart';

void main() => runApp(
    new MaterialApp(debugShowCheckedModeBanner: false, home: new MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BuildContext ctx = context;
    final title = 'Most wanted weather conditions';
    final List<String> pictures = <String>[
      'images/krakow.jpg',
      'images/debica.jpg',
      'images/jaslo.jpg',
      'images/olsztyn.jpg',
    ];
    final List<String> cities = <String>[
      'Kraków',
      'Dębica',
      'Jasło',
      'Olsztyn'
    ];
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        home: Scaffold(
          appBar: AppBar(title: Text(title), actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.info),
              tooltip: 'About',
              onPressed: () => {
                showDialog(
                    context: ctx,
                    builder: (context) {
                      return AlertDialog(
                        title: new Text("About app"),
                        content: new Text("Author: Adam Stelmach \nVersion: 1.0\nRelease date: 18.01.2021"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    })
              },
            )
          ]),
          body: CitiesList(pictures: pictures, cities: cities),
        ));
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

class CitiesList extends StatelessWidget {
  const CitiesList({
    Key key,
    @required this.pictures,
    @required this.cities,
  }) : super(key: key);

  final List<String> pictures;
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
