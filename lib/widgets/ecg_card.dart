import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goh/widgets/custom_clipper.dart';

import '../utils/const.dart';

class ECGHistoryCard extends StatelessWidget {
  late final Timestamp sdate;
  late final Timestamp edate;
  late final String classi_class;
  final Color color = Constants.lightBlue;
  ECGHistoryCard(
      {Key? key,
      required this.sdate,
      required this.edate,
      required this.classi_class
      // required this.value,
      // required this.unit,
      // required this.time,
      // required this.image,
      //required this.isDone
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cls_txt = classi_class.split(",");
    return Container(
        margin: const EdgeInsets.only(right: 15),
        height: 80,
        width: 300,
        decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          color: Colors.white,
        ),
        child: Stack(children: <Widget>[
          Positioned(
            child: ClipPath(
              clipper: MyCustomClipper(clipType: ClipType.halfCircle),
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  color: color.withOpacity(0.1),
                ),
                height: 100,
                width: 100,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Icon and Hearbeat
                    Icon(Icons.monitor_heart_outlined,
                        size: Constants.iconSize + 4),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                ((cls_txt[0] == '동리듬(정상)') || (cls_txt[0] == '측정중')) ? cls_txt[0] : cls_txt[0],
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Constants.textPrimary),
                              ),
                              SizedBox(height: 1),
                              Text(
                                '${sdate.toDate().toString().substring(0, 10)}',
                                style: TextStyle(
                                    fontSize: 12, color: Constants.textPrimary),
                              ),
                            ],
                          ),
                        ]))
                  ]))
        ]));
  }
}
