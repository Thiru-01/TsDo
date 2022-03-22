import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tsdo/constant.dart';
import 'package:tsdo/controller/controller.dart';
import 'package:tsdo/pages/homepage.dart';

final List<ChartData> chartData = [
  ChartData('Mon', 1),
  ChartData('Tue', 2),
  ChartData('Wed', 1),
  ChartData('Thru', 2),
  ChartData(
    'Fri',
    2,
  ),
  ChartData(
    'Sat',
    2,
  ),
  ChartData(
    'Sun',
    2,
  )
];

ControllerGet1 controllerGet1 = Get.put(ControllerGet1());
AlertDialog dialog = AlertDialog(
  content: const Text('Did you finished the task ?'),
  actions: [
    ElevatedButton(
        onPressed: () => navigator!.pop(),
        style: ElevatedButton.styleFrom(primary: Colors.red),
        child: const Text(
          "No",
          style: TextStyle(color: Colors.white),
        )),
    ElevatedButton(
        onPressed: () => navigator!.pop(),
        child: const Text(
          "Yes",
          style: TextStyle(color: Colors.white),
        )),
  ],
);

SfCartesianChart mordernGraph(List<ChartData> chartData, BuildContext context) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    series: <CartesianSeries>[
      SplineAreaSeries<ChartData, String>(
          dataSource: chartData,
          borderColor: primaryColor,
          borderWidth: 3,
          gradient: LinearGradient(
            stops: const [
              -0.001,
              0.36,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF6715b1).withOpacity(0.4),
              const Color(0xFFffffff).withOpacity(0.1),
            ],
          ),
          animationDuration: 20,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y)
    ],
    primaryXAxis: CategoryAxis(
      labelStyle: TextStyle(
          color: primaryColor.shade300,
          fontSize: scalefactor(context) * 12,
          fontWeight: FontWeight.bold),
      axisLine: const AxisLine(width: 0),
      majorGridLines: const MajorGridLines(width: 0),
      majorTickLines: const MajorTickLines(width: 0),
    ),
    primaryYAxis: NumericAxis(isVisible: false, maximum: 3),
    tooltipBehavior:
        TooltipBehavior(canShowMarker: false, shadowColor: primaryColor),
  );
}

Container card(double height, double width, context, String title) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: EdgeInsets.all(height * 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  text: "Title: ",
                  style: TextStyle(
                      color: Colors.black,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 16 * scalefactor(context)),
                  children: [
                TextSpan(
                    text: title,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: primaryColor.withOpacity(0.8)))
              ])),
          SizedBox(
            height: height * 0.09,
          ),
          Flexible(
              child: LinearPercentIndicator(
            backgroundColor: primaryColor.shade100,
            padding: const EdgeInsets.only(right: 10, left: 0),
            animation: true,
            progressColor: primaryColor,
            curve: Curves.easeInOutCubic,
            percent: 0.2,
            trailing: const Text('20 %'),
            barRadius: Radius.circular(width * 0.1),
            animationDuration: 1200,
            lineHeight: height * 0.05,
          )),
          SizedBox(
            height: height * 0.09,
          ),
          Flexible(
            child: RichText(
                text: TextSpan(
                    text: "Task: ",
                    style: TextStyle(
                        color: Colors.black,
                        wordSpacing: 2,
                        fontWeight: FontWeight.bold,
                        fontSize: 16 * scalefactor(context)),
                    children: [
                  TextSpan(
                      text: "Cinnamon Powder",
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 14 * scalefactor(context)))
                ])),
          ),
        ],
      ),
    ),
  );
}

showSheet(context, formKey) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(width(context) * 0.06),
              topRight: Radius.circular(width(context) * 0.06))),
      barrierColor: primaryColor.withOpacity(0.2),
      enableDrag: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(height(context) * 0.01),
                  child: Container(
                    height: height(context) * 0.007,
                    width: width(context) * 0.15,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Create Task",
                          style: TextStyle(
                              fontSize: 23 * scalefactor(context),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: height(context) * 0.5,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(height(context) * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Title",
                                      style: TextStyle(
                                          fontSize: 19 * scalefactor(context),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: height(context) * 0.01,
                                    ),
                                    TextFormField(
                                      controller:
                                          controllerGet1.titleController.value,
                                      validator: (value) {
                                        if (value!.isNotEmpty) {
                                          return null;
                                        }
                                        return 'Please give title';
                                      },
                                      style: TextStyle(
                                          color: primaryColor.withOpacity(0.8)),
                                      decoration: InputDecoration(
                                          hintText: 'Title',
                                          contentPadding: EdgeInsets.only(
                                              left: width(context) * 0.05,
                                              right: width(context) * 0.05),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: width(context) * 0.01,
                                                color: Colors.grey
                                                    .withOpacity(0.3)),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(height(context) * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date",
                                      style: TextStyle(
                                          fontSize: 19 * scalefactor(context),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: height(context) * 0.01,
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      validator: (value) {
                                        if (value!.isNotEmpty) {
                                          return null;
                                        }
                                        return 'Please set date';
                                      },
                                      textInputAction: TextInputAction.next,
                                      controller:
                                          controllerGet1.dateController.value,
                                      style: TextStyle(
                                          color: primaryColor.withOpacity(0.8)),
                                      onTap: () async {
                                        initializeDateFormatting();
                                        final DateFormat formatter =
                                            DateFormat('dd-MM-yyyy');
                                        DateTime? date = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2050));
                                        controllerGet1
                                            .dateSet(formatter.format(date!));
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Date and time',
                                          suffixIcon: const Icon(
                                              Icons.calendar_month_outlined),
                                          contentPadding: EdgeInsets.only(
                                              left: width(context) * 0.05,
                                              right: width(context) * 0.05),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: width(context) * 0.01,
                                                color: Colors.grey
                                                    .withOpacity(0.3)),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(height(context) * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date",
                                      style: TextStyle(
                                          fontSize: 19 * scalefactor(context),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: height(context) * 0.01,
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      validator: (value) {
                                        if (value!.isNotEmpty) {
                                          return null;
                                        }
                                        return 'Please set time';
                                      },
                                      controller:
                                          controllerGet1.timeController.value,
                                      style: TextStyle(
                                          color: primaryColor.withOpacity(0.8)),
                                      onTap: () async {
                                        final DateFormat formatter =
                                            DateFormat("h:mm a");
                                        TimeOfDay? time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now());
                                        final now = DateTime.now();
                                        controllerGet1.timeSet(formatter.format(
                                            DateTime(
                                                now.year,
                                                now.month,
                                                now.day,
                                                time!.hour,
                                                time.minute)));
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Time',
                                          suffixIcon: const Icon(Icons.timer),
                                          contentPadding: EdgeInsets.only(
                                              left: width(context) * 0.05,
                                              right: width(context) * 0.05),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: width(context) * 0.01,
                                                color: Colors.grey
                                                    .withOpacity(0.3)),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(height(context) * 0.02),
                                child: TextButton(
                                    onPressed: () {
                                      if (formKey.currentState.validate()) {
                                        controllerGet1.setQuery(context);
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                        minimumSize: Size(width(context),
                                            height(context) * 0.06),
                                        backgroundColor: primaryColor.shade800),
                                    child: Text(
                                      "Done",
                                      style: TextStyle(
                                          fontSize: 18 * scalefactor(context),
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

GlobalKey dkey = GlobalKey();
Widget secondMethod(context, formkey) {
  return SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height(context) * 0.05,
          width: double.infinity,
          child: Center(
            child: Text(
              "TO DO",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22 * scalefactor(context),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Obx(() => Expanded(
              child: SingleChildScrollView(
                child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, sep) {
                      return const Divider();
                    },
                    itemCount: controllerGet1.itemsData.length,
                    itemBuilder: (context, i) {
                      return Dismissible(
                          background: slideRightBackground(),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              controllerGet1.fillData(i);
                              controllerGet1.updateContent(i);
                              bool res = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return editDialog(i, context, formkey);
                                  });
                              return res;
                            }
                            final bool res = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return deletAlert(i, context);
                                });
                            return res;
                          },
                          secondaryBackground: slideLeftBackground(),
                          key: Key(controllerGet1.itemsData[i].taskname),
                          child: ListTile(
                            title: Text(
                              controllerGet1.itemsData[i].taskname
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17 * scalefactor(context)),
                            ),
                            trailing: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controllerGet1.itemsData[i].time,
                                  style: TextStyle(
                                      color: primaryColor.withOpacity(0.5)),
                                ),
                                Text(controllerGet1.itemsData[i].date,
                                    style: TextStyle(
                                        color: primaryColor.withOpacity(0.5)))
                              ],
                            ),
                          ));
                    }),
              ),
            )),
      ],
    ),
  );
}

AlertDialog deletAlert(int i, BuildContext context) {
  return AlertDialog(
    content: Text(
        "Are you sure you want to delete ${controllerGet1.itemsData[i].taskname}?"),
    actions: <Widget>[
      TextButton(
        child: const Text(
          "Cancel",
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
      TextButton(
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          controllerGet1.itemsData.removeAt(i);

          Navigator.of(context).pop(true);
        },
      ),
    ],
  );
}

AlertDialog editDialog(int i, BuildContext context, formkey) {
  return AlertDialog(
      actions: <Widget>[
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            controllerGet1.clearData();
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: const Text(
            "Edit",
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () {
            controllerGet1.updateContent(i);
            controllerGet1.clearData();
            Navigator.of(context).pop(false);
          },
        ),
      ],
      content: SizedBox(
        width: width(context),
        height: height(context) * 0.4,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(() => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(height(context) * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title",
                          style: TextStyle(
                              fontSize: 19 * scalefactor(context),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height(context) * 0.01,
                        ),
                        TextFormField(
                          controller: controllerGet1.titleController.value,
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            }
                            return 'Please give title';
                          },
                          style:
                              TextStyle(color: primaryColor.withOpacity(0.8)),
                          decoration: InputDecoration(
                              hintText: 'Title',
                              contentPadding: EdgeInsets.only(
                                  left: width(context) * 0.05,
                                  right: width(context) * 0.05),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: width(context) * 0.01,
                                    color: Colors.grey.withOpacity(0.3)),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(height(context) * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date",
                          style: TextStyle(
                              fontSize: 19 * scalefactor(context),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height(context) * 0.01,
                        ),
                        TextFormField(
                          readOnly: true,
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            }
                            return 'Please set date';
                          },
                          textInputAction: TextInputAction.next,
                          controller: controllerGet1.dateController.value,
                          style:
                              TextStyle(color: primaryColor.withOpacity(0.8)),
                          onTap: () async {
                            initializeDateFormatting();
                            final DateFormat formatter =
                                DateFormat('dd-MM-yyyy');
                            DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050));
                            controllerGet1.dateSet(formatter.format(date!));
                          },
                          decoration: InputDecoration(
                              hintText: 'Date and time',
                              suffixIcon:
                                  const Icon(Icons.calendar_month_outlined),
                              contentPadding: EdgeInsets.only(
                                  left: width(context) * 0.05,
                                  right: width(context) * 0.05),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: width(context) * 0.01,
                                    color: Colors.grey.withOpacity(0.3)),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(height(context) * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date",
                          style: TextStyle(
                              fontSize: 19 * scalefactor(context),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height(context) * 0.01,
                        ),
                        TextFormField(
                          readOnly: true,
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            }
                            return 'Please set time';
                          },
                          controller: controllerGet1.timeController.value,
                          style:
                              TextStyle(color: primaryColor.withOpacity(0.8)),
                          onTap: () async {
                            final DateFormat formatter = DateFormat("h:mma");
                            final timeFormtter = DateFormat.jm();
                            TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(timeFormtter
                                    .parse(controllerGet1.itemsData[i].time)));
                            final now = DateTime.now();
                            controllerGet1.timeSet(formatter.format(DateTime(
                                now.year,
                                now.month,
                                now.day,
                                time!.hour,
                                time.minute)));
                          },
                          decoration: InputDecoration(
                              hintText: 'Time',
                              suffixIcon: const Icon(Icons.timer),
                              contentPadding: EdgeInsets.only(
                                  left: width(context) * 0.05,
                                  right: width(context) * 0.05),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: width(context) * 0.01,
                                    color: Colors.grey.withOpacity(0.3)),
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ));
}

Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}

Widget slideRightBackground() {
  return Container(
    color: Colors.green,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            "Edit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}
