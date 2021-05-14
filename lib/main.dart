import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import "dart:math";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:graphview/GraphView.dart';

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  List<_SalesData> data = [
    _SalesData('imp Groups', 0),
    _SalesData('groups', 12),
    _SalesData('imp Contacts', 2),
    _SalesData('contacts', 54),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
          leading: ElevatedButton(
            child: Text('graph'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return GraphPage();
                }),
              );
            },
          ),
        ),
        body: Column(children: [
          Container(
            width: 400,
            child: SfCircularChart(
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: CircleAvatar(
                      radius: 45.0,
                      backgroundImage: AssetImage('images/avatar1.png')),
                ),
              ],
              palette: [
                Colors.orange[300]!,
                Colors.blue[300]!,
                Colors.red[300]!,
                Colors.green[300]!
              ],
              legend: Legend(isVisible: true),
              series: <CircularSeries>[
                // Renders radial bar chart
                RadialBarSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  cornerStyle: CornerStyle.endCurve,
                  dataLabelSettings: DataLabelSettings(
                      // Renders the data label
                      isVisible: true),
                ),
              ],
            ),
          ),
        ]));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class GraphPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  GraphPage({Key? key}) : super(key: key);

  @override
  GraphPageState createState() => GraphPageState();
}

class GraphPageState extends State<GraphPage> {
  void lalala() async {
    var res = await http.get(Uri.parse("http://localhost:3000/currentPerson"));
    var data = json.decode(res.body);
    CurrentUser currentUser = CurrentUser.fromJson(data);

    print(res.body.toString());
    print(currentUser.groupsCount.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            child: Text('http'),
            onPressed: () {
              lalala();
            },
          ),
        ],
        title: const Text('Syncfusion Flutter chart'),
        leading: Row(
          children: [
            ElevatedButton(
              child: Text('back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

class CurrentUser {
  int? id;
  String? name;
  String? avatar;
  int? groupsCount;
  int? importaintGroupsCount;
  int? usersCount;
  int? importaintUsersCount;

  CurrentUser(
      {this.id,
      this.name,
      this.avatar,
      this.groupsCount,
      this.importaintGroupsCount,
      this.usersCount,
      this.importaintUsersCount});

  factory CurrentUser.fromJson(Map<String, dynamic> json) {
    return CurrentUser(
      id: json["id"],
      name: json["name"],
      avatar: json["avatar"],
      groupsCount: json["groupsCount"],
      importaintGroupsCount: json["importaintGroupsCount"],
      usersCount: json["usersCount"],
      importaintUsersCount: json["importaintUsersCount"],
    );
  }
}

class User {
  int? id;
  String? name;
  String? avatar;
  bool? isImportaint;

  User({this.id, this.name, this.avatar, this.isImportaint});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        isImportaint: json["isImportaint"]);
  }
}

class Group {
  int? id;
  String? name;
  String? avatar;
  bool? isImportaint;

  User({this.id, this.name, this.avatar, this.isImportaint});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        isImportaint: json["isImportaint"]);
  }
}
