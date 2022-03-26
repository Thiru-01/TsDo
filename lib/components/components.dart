import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tsdo/constant.dart';
import 'package:tsdo/controller/controller.dart';

final DateFormat formatter = DateFormat('dd-MM-yyyy');
final DateFormat timeFormatter = DateFormat('h:mm a');
final DataController dataConroller = Get.find(tag: "controllerData");
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

Container card(double height, double width, context, String title,
    double percent, String valuePer) {
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
              percent: percent,
              trailing: Text('$valuePer %'),
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
                        text: dataConroller.selectedString.value,
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 14 * scalefactor(context)))
                  ])),
            ),
          ],
        ),
      ));
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
                                          dataConroller.titleController.value,
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
                                          dataConroller.dateController.value,
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
                                        dataConroller
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
                                          dataConroller.timeController.value,
                                      style: TextStyle(
                                          color: primaryColor.withOpacity(0.8)),
                                      onTap: () async {
                                        final DateFormat formatter =
                                            DateFormat("h:mm a");
                                        TimeOfDay? time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now());
                                        final now = DateTime.now();
                                        dataConroller.timeSet(formatter.format(
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
                                        dataConroller.setQuery(context);
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
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, sep) {
                    return const Divider();
                  },
                  itemCount: dataConroller.itemsData.length,
                  itemBuilder: (context, i) {
                    return Dismissible(
                        background: slideRightBackground(),
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            dataConroller.fillData(i);
                            dataConroller.updateContent(i);
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
                        key: Key(dataConroller.itemsData[i].taskname),
                        child: ListTile(
                          title: Text(
                            dataConroller.itemsData[i].taskname
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
                                dataConroller.itemsData[i].time,
                                style: TextStyle(
                                    color: primaryColor.withOpacity(0.5)),
                              ),
                              Text(dataConroller.itemsData[i].date,
                                  style: TextStyle(
                                      color: primaryColor.withOpacity(0.5)))
                            ],
                          ),
                        ));
                  }),
            )),
      ],
    ),
  );
}

AlertDialog deletAlert(int i, BuildContext context) {
  return AlertDialog(
    content: Text(
        "Are you sure you want to delete ${dataConroller.itemsData[i].taskname}?"),
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
          dataConroller.itemsData.removeAt(i);

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
            dataConroller.clearData();
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: const Text(
            "Edit",
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () {
            dataConroller.updateContent(i);
            dataConroller.clearData();
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
                          controller: dataConroller.titleController.value,
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
                          controller: dataConroller.dateController.value,
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
                            dataConroller.dateSet(formatter.format(date!));
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
                          controller: dataConroller.timeController.value,
                          style:
                              TextStyle(color: primaryColor.withOpacity(0.8)),
                          onTap: () async {
                            final DateFormat formatter = DateFormat("h:mma");
                            final timeFormtter = DateFormat.jm();
                            TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(timeFormtter
                                    .parse(dataConroller.itemsData[i].time)));
                            final now = DateTime.now();
                            dataConroller.timeSet(formatter.format(DateTime(
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
