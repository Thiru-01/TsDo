import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tsdo/model/taskmodel.dart';
import 'package:tsdo/services/storeservice.dart';

class ControllerGet1 extends GetxController {
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> timeController = TextEditingController().obs;
  Rx<TextEditingController> titleController = TextEditingController().obs;
  RxList itemsData = [].obs;
  final DataRepository dataRepository = DataRepository();
  setQuery(context) {
    TaskModel data = TaskModel(
        taskname: titleController.value.text,
        state: 0,
        time: timeController.value.text,
        date: dateController.value.text);

    dataRepository.addTask(data);
    navigator!.pop(context);
    dateController.value.clear();
    timeController.value.clear();
    titleController.value.clear();
    getQuery();
  }

  getQuery() {
    dataRepository.getStream().forEach((element) {
      itemsData.clear();
      for (var e in element.docs) {
        Map<String, dynamic> item = e.data() as Map<String, dynamic>;
        TaskModel data = taskModelFromMap(item);
        itemsData.add(data);
      }
    });
  }

  dateSet(String date) {
    dateController.value.text = date;
  }

  timeSet(String time) {
    timeController.value.text = time;
  }

  clearandSetData(context) {
    itemsData.add(TaskModel(
        taskname: titleController.value.text,
        state: 0,
        time: timeController.value.text,
        date: dateController.value.text));

    navigator!.pop(context);
    dateController.value.clear();
    timeController.value.clear();
    titleController.value.clear();
  }

  clearData() {
    dateController.value.clear();
    timeController.value.clear();
    titleController.value.clear();
  }

  updateContent(int i) {
    TaskModel data = itemsData[i];
    data.taskname = titleController.value.text;
    data.time = timeController.value.text;
    data.date = dateController.value.text;
  }

  fillData(int i) {
    TaskModel data = itemsData[i];
    titleController.value.text = data.taskname;
    timeController.value.text = data.time;
    dateController.value.text = data.date;
  }
}

class ControllerGet2 extends GetxController {
  Rx<int> state = 0.obs;

  changeState(int value) {
    state.value = value;
  }
}
