// To parse this JSON data, do
//
//     final taskModel = taskModelFromMap(jsonString);
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

TaskModel taskModelFromMap(Map<String, dynamic> str) => TaskModel.fromMap(str);

String taskModelToMap(TaskModel data) => json.encode(data.toMap());

class TaskModel {
  TaskModel(
      {required this.taskname,
      required this.state,
      required this.time,
      required this.date,
      required this.timestamp});

  String taskname;
  int state;
  String time;
  String date;
  Timestamp timestamp;

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
      taskname: json["taskname"],
      state: json["state"],
      time: json["time"],
      date: json["date"],
      timestamp: json['timestamp']);

  Map<String, dynamic> toMap() => {
        "taskname": taskname,
        "state": state,
        "time": time,
        "date": date,
        "timestamp": timestamp
      };
}
