import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goh/widgets/Cal_history_widget.dart';
import 'package:goh/widgets/card_section.dart';
import 'package:goh/widgets/custom_clipper.dart';
import 'package:goh/widgets/ecg_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:io';
import 'package:goh/utils/const_data.dart';
import 'dart:async';

import '../utils/const.dart';

class ECGListPage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  ECGListPage({super.key});
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<ECGListPage> {
  late List<ECGData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  final db = FirebaseFirestore.instance;
  // final _filepath =
  //     "/Users/0hyun/Desktop/flutter/flutter_test_proj/mediapp/mediapp/assets/icons/data.csv";
  // String _filename = '';

  // Future<void> getFromCSV() async {
  //   final filename = await DefaultAssetBundle.of(context).loadString(_filepath);
  //   setState(() {
  //     _filename = filename;
  //   });
  // }

  @override
  void initState() {
    // _chartData = getChartData();
    // print(_chartData.runtimeType);
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    // widget.storage.getFromCSV().then((value) => print(value));
    // .readCsv()
    // .then((value) => setState(() => {_filename = value}));
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return StreamBuilder<QuerySnapshot>(
        stream: db.collection('ECG').orderBy('stime').snapshots(),
        builder: (context, snapshotECG) {
          bool isLoadingECG = !snapshotECG.hasData;
          return (isLoadingECG)? Stack():Stack(
            children: <Widget>[
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
                child: ListView(children: <Widget>[ 
                SizedBox(
                      height: Constants.headerHeight * 0.03),
                
                Container(
                  child: Row(
                    children: <Widget>[
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
                          backgroundImage:
                              AssetImage('assets/icons/woman.png'))
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "심전도 그래프 리스트",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ),])),
                SizedBox(height: 50),
                Container(
                  child: Column(
                    children: !isLoadingECG
                        ? List<Widget>.from(snapshotECG
                            .data!.docs.reversed
                            .map((e) =>CalECGHistory(
                              e['stime']
                                  .toDate()
                                  .toString()
                                  .substring(0, 10),
                              e['class'],e['ecg'])))

                    // widget type when no ECG data in DB
                    : <Widget>[
                        CardSection(
                            bp_val: "loading data ECG",
                            pulse_val: "loading data ECG")
                      ],
              )),]))
          ]);
        });
  }
}

class ECGData {
  ECGData(this.time, this.val);
  final double time;
  final double val;
}
