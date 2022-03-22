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
  @override
  void initState() {
    controllerGet1.getQuery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ControllerGet2 controllerGet2 = Get.put(ControllerGet2());

    GlobalKey formkey = GlobalKey<FormState>();
    List<Widget> screens = [
      mainMethod(context, chartData),
      secondMethod(context, formkey)
    ];
    return Obx(() => Scaffold(
          body: screens[controllerGet2.state.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controllerGet2.state.value == 1 ? 2 : 0,
            selectedItemColor: primaryColor.shade700,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (value) {
              if (value == 1) {
                showSheet(context, formkey);
              } else {
                controllerGet2.changeState(value == 0 ? 0 : value - 1);
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

  SafeArea mainMethod(BuildContext context, List<ChartData> chartData) {
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
            mordernGraph(chartData, context),
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
            SizedBox(
              height: height(context) * 0.2,
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: card(height(context) * 0.15, width(context) * 0.5,
                          context, "Yesterday Report"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: card(height(context) * 0.15, width(context) * 0.5,
                          context, "Last Month Report"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: card(height(context) * 0.15, width(context) * 0.5,
                          context, "Last Month Report"),
                    ),
                  ],
                ),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      text: "Status: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          wordSpacing: 2,
                                          fontSize: 15 * scalefactor(context)),
                                      children: const [
                                    TextSpan(
                                        text: 'Pending',
                                        style: TextStyle(
                                            color: Colors.redAccent,
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
                                          fontSize: 15 * scalefactor(context)),
                                      children: const [
                                    TextSpan(
                                        text: '9.30 Am',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))
                                  ])),
                            ],
                          )
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
            )
          ]),
        ),
      ),
    );
  }

  SfCartesianChart mordernGraph(
      List<ChartData> chartData, BuildContext context) {
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
}

mixin InputValidationMixin {}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
