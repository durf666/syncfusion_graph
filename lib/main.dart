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
  var graph = {
    "graph": {
      "nodes": [
        {
          "id": 1,
          "name": "Test User 1 (current)",
          "type": "currentUser",
          "isImportaint": false
        },
        {"id": 2, "name": "Test User 2", "type": "user", "isImportaint": false},
        {"id": 3, "name": "Test User 3", "type": "user", "isImportaint": true},
        {"id": 4, "name": "Test User 4", "type": "user", "isImportaint": false},
        {"id": 5, "name": "Test User 5", "type": "user", "isImportaint": false},
        {"id": 6, "name": "Test User 6", "type": "user", "isImportaint": false},
        {"id": 7, "name": "Test Group 1", "type": "user", "isImportaint": true},
        {"id": 8, "name": "Test Group 2", "type": "user", "isImportaint": false}
      ],
      "edges": [
        {"from": 1, "to": 2},
        {"from": 1, "to": 3},
        {"from": 1, "to": 4},
        {"from": 1, "to": 5},
        {"from": 1, "to": 6},
        {"from": 1, "to": 7},
        {"from": 1, "to": 8}
      ]
    }
  };
  void lalala() async {
    print(graph.runtimeType);
    var res = await http.get(Uri.parse("http://localhost:3000/currentPerson"));
    var data = json.decode(res.body);
    var personData = data["persons"] as List;
    var groupsData = data["groups"] as List;
    CurrentPerson currentUser = CurrentPerson.fromJson(data);
    print(res.body.toString());
    print(currentUser.groupsCount.toString());
    var userList =
        personData.map<Person>((json) => Person.fromJson(json)).toList();
    print(userList[1].name.toString());
    var groupList =
        groupsData.map<Group>((json) => Group.fromJson(json)).toList();
    print(groupList[1].name.toString());
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
              var node = Node.Id(1);
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

class CurrentPerson {
  int? id;
  String? name;
  String? avatar;
  int? groupsCount;
  int? importaintGroupsCount;
  int? usersCount;
  int? importaintUsersCount;

  CurrentPerson(
      {this.id,
      this.name,
      this.avatar,
      this.groupsCount,
      this.importaintGroupsCount,
      this.usersCount,
      this.importaintUsersCount});

  factory CurrentPerson.fromJson(Map<String, dynamic> json) {
    return CurrentPerson(
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

class Person {
  int? id;
  String? name;
  String? avatar;
  bool? isImportaint;

  Person({this.id, this.name, this.avatar, this.isImportaint});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
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

  Group({this.id, this.name, this.avatar, this.isImportaint});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        isImportaint: json["isImportaint"]);
  }
}

class GraphData {}

class Nodes {}

class Edges {}
