import 'package:flutter/material.dart';

import 'CityWeather.dart';

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