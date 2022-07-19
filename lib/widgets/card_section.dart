import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goh/utils/const.dart';
import 'package:goh/widgets/custom_clipper.dart';
import 'package:goh/widgets/card_main.dart';

class CardSection extends StatelessWidget {
  final String pulse_val;
  final String bp_val;
  // final String unit;
  // final String time;
  // final ImageProvider image;
  // final bool isDone;

  CardSection({Key? key, required this.pulse_val, required this.bp_val
      // required this.value,
      // required this.unit,
      // required this.time,
      // required this.image,
      //required this.isDone
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Align(
      alignment: Alignment.topLeft,
      child: 
      Container(
        margin: const EdgeInsets.only(right: 15.0),
        width: 300,
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
                child: ListView(
                  scrollDirection: Axis.horizontal, 
                  children: <Widget>[
                    Stack(children: <Widget>[
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
                ])

                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: <Widget>[
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: <Widget>[
                //         Image(
                //           image: image,
                //           width: 24,
                //           height: 24,
                //           color: Theme.of(context).accentColor,
                //         ),

                //         Text(
                //             time,
                //             style: TextStyle(
                //                 fontSize: 15,
                //                 color: Constants.textPrimary
                //             ),
                //         ),
                //       ],
                //     ),
                //     SizedBox(height: 10),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: <Widget>[
                //         Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: <Widget>[
                //               Text(title,
                //                   overflow: TextOverflow.ellipsis,
                //                   style: TextStyle(
                //                       fontSize: 20,
                //                       fontWeight: FontWeight.bold,
                //                       color: Constants.textPrimary
                //                   ),
                //               ),
                //               SizedBox(height: 5),
                //               Text('$value $unit',
                //                   style: TextStyle(
                //                       fontSize: 15,
                //                       color: Constants.textPrimary
                //                   ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         SizedBox(width: 10),

                //       ],
                //     ),
                //   ],
                // ),
                )
          ],
        ),
      ),
    );
  }
}
