import 'package:flutter/material.dart';
import 'package:goh/utils/const.dart';
import 'package:goh/widgets/bp_chart.dart';
import 'package:goh/widgets/custom_clipper.dart';
import 'package:goh/widgets/ecgGraphWidget.dart';

import '../screens/detail_screen.dart';

class CalECGHistory extends StatelessWidget {
  late String date;
  late var cls;
  late var ecgList;

  CalECGHistory(date, cls, ecgList, {Key? key}) : super(key: key) {
    this.date = date;
    this.cls = cls;
    this.ecgList = ecgList;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
            // margin: const EdgeInsets.only(right: 15),
            height: 80,
            width: 350,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              shape: BoxShape.rectangle,
              color: Colors.white,
            ),
            child: Stack(children: <Widget>[
              Positioned(
                child: ClipPath(
                  clipper: MyCustomClipper(clipType: ClipType.halfCircle),
                  child: Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Constants.lightBlue.withOpacity(0.1),
                    ),
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.monitor_heart_outlined,
                                  size: Constants.iconSize),
                              Text('  ECG ',
                                  style: TextStyle(
                                      fontSize: 10, color: Constants.textDark)),
                            ]),
                        SizedBox(width: 30),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${cls.split(',')[0]}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Constants.textPrimary),
                                  ),
                                  SizedBox(height: 1),
                                  Text(
                                    '$date',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Constants.textPrimary),
                                  ),
                                ],
                              ),
                            ]))
                      ]))
            ])),
      ),
      onTap: () {
        //InkWell test code
        // debugPrint("CARD main clicked. redirect to details page");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ECGChart(ecgList)),
        );
      });
  }
}
Widget calBPHistory({pulse_val, bp_val}) {
  return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        // margin: const EdgeInsets.only(right: 15.0),
        width: 350,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          color: Colors.white,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: ClipPath(
                clipper: MyCustomClipper(clipType: ClipType.semiCircle),
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Constants.lightBlue.withOpacity(0.1),
                  ),
                  height: 120,
                  width: 120,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Stack(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Image(
                            width: 32,
                            height: 32,
                            image: AssetImage('assets/icons/heartbeat.png'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Heartbeat',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13, color: Constants.textDark),
                          ),
                          SizedBox(
                            width: 75,
                          ),
                          Text(
                            '$pulse_val',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Constants.textDark,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'bpm',
                            style: TextStyle(
                                fontSize: 15, color: Constants.textDark),
                          ),
                        ]),
                        SizedBox(height: 20),
                        Row(children: <Widget>[
                          Image(
                            width: 32,
                            height: 32,
                            image: AssetImage('assets/icons/blooddrop.png'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Blood\nPressure',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13, color: Constants.textDark),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            '$bp_val',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Constants.textDark,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'mmHg',
                            style: TextStyle(
                                fontSize: 15, color: Constants.textDark),
                          ),
                        ])
                      ],
                    ))
              ]),
            )
          ],
        ),
      ));
}
