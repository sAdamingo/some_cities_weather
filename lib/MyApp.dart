import 'package:flutter/material.dart';

import 'CitiesList.dart';
import 'main.dart';

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
                        content: new Text(
                            "Author: Adam Stelmach \nVersion: 1.0\nRelease date: 18.01.2021"),
                        actions: <Widget>[
                          TextButton(
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