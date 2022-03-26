import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tsdo/components/components.dart';
import 'package:tsdo/constant.dart';
import 'package:tsdo/controller/controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StateController stateController = Get.put(StateController());
  @override
  void initState() {
    dataConroller.getQuery();
    dataConroller.getGraphData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey formkey = GlobalKey<FormState>();
    List<Widget> screens = [
      mainMethod(context),
      secondMethod(context, formkey)
    ];
    return Obx(() => Scaffold(
          body: screens[stateController.state.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: stateController.state.value == 1 ? 2 : 0,
            selectedItemColor: primaryColor.shade700,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (value) {
              if (value == 1) {
                showSheet(context, formkey);
              } else {
                stateController.changeState(value == 0 ? 0 : value - 1);
              }
            },
            iconSize: height(context) * 0.04,
            unselectedItemColor: Colors.grey,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  height: height(context) * 0.06,
                  width: width(context) * 0.13,
                  child: Icon(
                    Icons.add,
                    size: height(context) * 0.04,
                    color: Colors.white,
                  ),
                ),
                label: 'Create',
              ),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.timelapse), label: 'Time'),
            ],
          ),
        ));
  }

  SafeArea mainMethod(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(width(context) * 0.02),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.all(width(context) * 0.05),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: width(context) * 0.1,
                  ),
                  SizedBox(width: width(context) * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Hello",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: scalefactor(context) * 22,
                                  fontWeight: FontWeight.bold),
                              children: [
                            TextSpan(
                                text: 'Thiru !',
                                style: TextStyle(color: primaryColor.shade700))
                          ])),
                      Text(
                        "October 1",
                        style: TextStyle(
                            fontSize: scalefactor(context) * 15,
                            fontWeight: FontWeight.w200),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width(context) * 0.05, bottom: width(context) * 0.02),
              child: Text(
                "Your Weekly achivement",
                style: TextStyle(
                    fontSize: scalefactor(context) * 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() => Padding(
                  padding: EdgeInsets.only(
                      left: width(context) * 0.05,
                      right: width(context) * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(width(context) * 0.01),
                            border: Border.all(
                                width: 1, color: primaryColor.shade100)),
                        constraints: BoxConstraints(
                          maxWidth: width(context) * 0.4,
                        ),
                        height: height(context) * 0.06,
                        child: Center(
                          child: DropdownButton<String>(
                              value: dataConroller.dropValue.string,
                              elevation: 0,
                              menuMaxHeight: height(context) * 0.2,
                              underline: Container(),
                              items: const [
                                DropdownMenuItem(
                                    value: "cin",
                                    child: Text("Cinnamon Powder")),
                                DropdownMenuItem(
                                  value: "fen",
                                  child: Text("Fenugreek Water"),
                                ),
                              ],
                              onChanged: (item) {
                                dataConroller.changeDrop(item!);
                              }),
                        ),
                      ),
                    ],
                  ),
                )),
            mordernGraph(context),
            Padding(
              padding: EdgeInsets.only(
                  left: width(context) * 0.05, bottom: width(context) * 0.02),
              child: Text(
                "Ongoing Task",
                style: TextStyle(
                    fontSize: scalefactor(context) * 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height(context) * 0.2,
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Obx(() => Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: card(
                              height(context) * 0.15,
                              width(context) * 0.5,
                              context,
                              "Yesterday Report",
                              dataConroller.yester.value.toDouble(),
                              (dataConroller.yester.value * 100.00).toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: card(
                              height(context) * 0.15,
                              width(context) * 0.5,
                              context,
                              "Last Week Report",
                              (dataConroller.weekTotal.value / 7),
                              ((dataConroller.weekTotal.value / 7) * 100)
                                  .toPrecision(2)
                                  .toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: card(
                              height(context) * 0.15,
                              width(context) * 0.5,
                              context,
                              "Last Month Report",
                              0.0,
                              "0"),
                        ),
                      ],
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width(context) * 0.05, bottom: width(context) * 0.02),
              child: Text(
                "Today's Work",
                style: TextStyle(
                    fontSize: scalefactor(context) * 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: height(context) * 0.01, right: height(context) * 0.01),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return dialog;
                      });
                },
                child: Container(
                  padding: EdgeInsets.all(width(context) * 0.02),
                  height: height(context) * 0.07,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cinnamon powder",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15 * scalefactor(context),
                                fontWeight: FontWeight.bold),
                          ),
                          Obx(() => Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          text: "Status: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              wordSpacing: 2,
                                              fontSize:
                                                  15 * scalefactor(context)),
                                          children: [
                                        TextSpan(
                                            text: dataConroller
                                                    .yester.value.isEven
                                                ? 'Pending'
                                                : "Done",
                                            style: TextStyle(
                                                color: dataConroller
                                                        .yester.value.isEven
                                                    ? Colors.redAccent
                                                    : Colors.green,
                                                fontWeight: FontWeight.bold))
                                      ])),
                                  SizedBox(
                                    height: height(context) * 0.01,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                          text: "Time: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              wordSpacing: 2,
                                              fontSize:
                                                  15 * scalefactor(context)),
                                          children: const [
                                        TextSpan(
                                            text: '9.30 Am',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold))
                                      ])),
                                ],
                              ))
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor.shade100,
                      borderRadius:
                          BorderRadius.circular(width(context) * 0.01)),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget mordernGraph(BuildContext context) {
    return Obx(() => SfCartesianChart(
          plotAreaBorderWidth: 0,
          enableAxisAnimation: true,
          series: <CartesianSeries>[
            SplineAreaSeries<ChartData, String>(
                // ignore: invalid_use_of_protected_member
                dataSource: dataConroller.chartData.value,
                borderColor: primaryColor,
                animationDelay: 150,
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
                animationDuration: 1500,
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
          primaryYAxis: NumericAxis(
              isVisible: false,
              maximum: 3,
              rangePadding: ChartRangePadding.additional),
          tooltipBehavior:
              TooltipBehavior(canShowMarker: false, shadowColor: primaryColor),
        ));
  }
}

mixin InputValidationMixin {}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
