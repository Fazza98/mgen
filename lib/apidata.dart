import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse("https://dummy.restapiexample.com/api/v1/employees"));

  if (response.statusCode == 200) {
    print(response.body);
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final int id;
  final String employee_name;
  final int employee_salary;
  final int employee_age;
  final String profile_image;

  Album(
      {required this.id,
      required this.employee_name,
      required this.employee_salary,
      required this.employee_age,
      required this.profile_image});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        id: json["id"],
        employee_name: json['employee_name'],
        employee_salary: json['employee_salary'],
        employee_age: json["employee age"],
        profile_image: json["profile_image"]);
  }
}

void main() => runApp(api());

class api extends StatefulWidget {
  api({Key? key}) : super(key: key);

  @override
  _apiState createState() => _apiState();
}

class _apiState extends State<api> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetching Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('API'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.employee_name);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
