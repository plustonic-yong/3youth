import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:goh/utils/const.dart';
import 'package:goh/widgets/custom_clipper.dart';

class ECGChart extends StatefulWidget {
  var ecg_data;
  ECGChart(ecg_list) {
    if (ecg_list.length > 12*31){
      ecg_data = ecg_list.sublist(0,371);
    }else{
      ecg_data = ecg_list;
    }

  }
  @override
  _ECGChart createState() => _ECGChart(ecg_data);
}

class _ECGChart extends State<ECGChart> {
  var ecg_data;
  List<FlSpot> ecg_spot = [];
  _ECGChart(ecg_list) {
    ecg_data = ecg_list;
    int idx = 0;
    for (var a in ecg_data) {
      // print(a);
      // print(a.runtimeType);
    }
    for (var a in ecg_data) {
      int k = a;
      if (a < 0) {
        continue;
      }
      ecg_spot.add(FlSpot(idx.toDouble(), k.toDouble()));
      idx += 1;
    }
  }
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    IconData icon;
    Color color;
    switch (value.toInt()) {
      case 0:
        icon = Icons.wb_sunny;
        color = const Color(0xFFffab01);
        break;
      case 2:
        icon = Icons.wine_bar_sharp;
        color = const Color(0xFFff0000);
        break;
      case 4:
        icon = Icons.watch_later;
        color = Colors.green;
        break;
      case 6:
        icon = Icons.whatshot;
        color = Colors.deepOrangeAccent;
        break;
      default:
        throw StateError("Invalid");
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Icon(
        icon,
        color: color,
        size: 32,
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black87, fontSize: 10);
    String text;
    text = (value.toInt() / 12 < 31)?(value.toInt() / 12).toInt().toString() + '초':"";
    return SideTitleWidget(
      axisSide: meta.axisSide,
      // child: Text(meta.formattedValue, style: style),
      child: Text(text, style: style, textAlign: TextAlign.center,)
    );
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    // TODO: implement build
    return Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: SafeArea(
            child: Stack(children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Theme.of(context).accentColor,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),
          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(Constants.paddingSide),
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      "Lee Yu Gyung님",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ),
                  CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage('assets/icons/woman.png'))
                ]),
                Container(
                    child: Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      "심전도 그래프 리스트",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ),
                ])),
                SizedBox(height: 50),
                AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 238, 237, 244),
                                Color.fromARGB(255, 240, 239, 241),
                              ],
                            ),
                            color: Color(0xff232d37)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: LineChart(LineChartData(
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                              ),
                              // titlesData: FlTitlesData(show: false),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 20,
                                    getTitlesWidget: bottomTitleWidgets,
                                    interval: 46,
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  drawBehindEverything: true,
                                  sideTitles: SideTitles(
                                    interval: 2,
                                    showTitles: false,
                                    getTitlesWidget: leftTitleWidgets,
                                    reservedSize: 0,
                                  ),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                      color: Color.fromARGB(255, 186, 204, 218),
                                      width: 1)),
                              //
                              //           titlesData: FlTitlesData(
                              //             topTitles: AxisTitles(),
                              //             leftTitles: AxisTitles(),
                              //             bottomTitles: AxisTitles(
                              //               sideTitles: SideTitles(
                              //                 showTitles: false,
                              //                 interval: 3,
                              //             )),
                              //             ),
                              lineBarsData: [
                                LineChartBarData(
                                  dotData: FlDotData(show: false),
                                  spots: ecg_spot,
                                  isCurved: false,
                                  barWidth: 2,
                                  color: Colors.red,
                                )
                              ])),
                        )))
              ]))
        ])));
  }
}
