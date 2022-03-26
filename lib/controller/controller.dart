import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tsdo/components/components.dart';
import 'package:tsdo/constant.dart';
import 'package:tsdo/model/taskmodel.dart';
import 'package:tsdo/pages/homepage.dart';
import 'package:tsdo/services/storeservice.dart';

class DataController extends GetxController {
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> timeController = TextEditingController().obs;
  Rx<TextEditingController> titleController = TextEditingController().obs;
  RxList<ChartData> chartData = <ChartData>[].obs;
  RxList itemsData = [].obs;
  RxInt weekTotal = 0.obs;
  RxInt yester = 0.obs;
  RxString dropValue = "cin".obs;
  RxString selectedString = "Cinnamon Powder".obs;
  late DataRepository dataRepository;

  @override
  void onInit() {
    dataRepository = DataRepository(dropValue.value);
    super.onInit();
  }

  changeRef() {
    dataRepository.setRefe();
  }

  setQuery(context) {
    DateTime time = timeFormatter.parse(timeController.value.text);
    DateTime date = formatter.parse(dateController.value.text);
    TaskModel data = TaskModel(
        taskname: titleController.value.text,
        state: 0,
        timestamp: Timestamp.fromDate(DateTime(date.year, date.month, date.day,
            time.hour, time.minute, time.second)),
        time: timeController.value.text,
        date: dateController.value.text);

    dataRepository.addCin(data);
    navigator!.pop(context);
    dateController.value.clear();
    timeController.value.clear();
    titleController.value.clear();
    getQuery();
  }

  getQuery() async {
    QuerySnapshot<Object?> query = await dataRepository.getStream();

    itemsData.clear();
    for (var e in query.docs) {
      Map<String, dynamic> item = e.data() as Map<String, dynamic>;
      if (item.isNotEmpty) {
        TaskModel data = taskModelFromMap(item);
        itemsData.add(data);
      }
    }
  }

  changeDrop(String value) {
    dropValue.value = value;
    selectedString.value =
        value == "cin" ? "Cinnamon Powder" : "Fenugreek Water";
  }

  getGraphData() async {
    QuerySnapshot<Object?> query = await dataRepository.get7days();
    chartData.clear();
    var state = query.docs.first.data() as Map<String, dynamic>;
    if (state.isNotEmpty) yester.value = state['state'];
    int count = 0;
    weekTotal.value = 0;
    for (var e in query.docs) {
      Map<String, dynamic> item = e.data() as Map<String, dynamic>;
      if (item.isNotEmpty) {
        TaskModel data = taskModelFromMap(item);
        weekTotal.value = weekTotal.value + data.state;
        chartData.add(ChartData(days[count], data.state.toDouble()));
        count++;
      }
    }
  }

  updateState(int state, TaskModel data) {
    data.state = state;
    dataRepository.updateTask(data);
  }

  dateSet(String date) {
    dateController.value.text = date;
  }

  timeSet(String time) {
    timeController.value.text = time;
  }

  clearandSetData(context) {
    DateTime time = timeFormatter.parse(timeController.value.text);
    DateTime date = formatter.parse(dateController.value.text);
    itemsData.add(TaskModel(
        taskname: titleController.value.text,
        timestamp: Timestamp.fromDate(DateTime(date.year, date.month, date.day,
            time.hour, time.minute, time.second)),
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
    dataRepository.updateTask(data);
  }

  fillData(int i) {
    TaskModel data = itemsData[i];
    titleController.value.text = data.taskname;
    timeController.value.text = data.time;
    dateController.value.text = data.date;
  }
}

class StateController extends GetxController {
  Rx<int> state = 0.obs;

  changeState(int value) {
    state.value = value;
  }
}
