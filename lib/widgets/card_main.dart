import 'package:flutter/material.dart';
import 'package:goh/screens/detail_screen.dart';
import 'package:goh/utils/const.dart';
import 'package:goh/widgets/custom_clipper.dart';

class CardMainWidget extends StatelessWidget {
  late String pulse;
  late String bp;
  late bool hasData;
  CardMainWidget(
      {required String pulse, required String bp, required bool hasData}) {
    this.pulse = pulse;
    this.bp = bp;
    this.hasData = hasData;
  }

  @override
  Widget build(BuildContext context) {
    if (hasData) {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CardMain(
            image: AssetImage('assets/icons/heartbeat.png'),
            title: "Hearbeat",
            value: pulse,
            unit: "bpm",
            color: Constants.lightGreen,
          ),
          CardMain(
              image: AssetImage('assets/icons/blooddrop.png'),
              title: "Blood\nPressure",
              value: bp,
              unit: "mmHg",
              color: Constants.lightYellow)
        ],
      );
    } else {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CardMain(
            image: AssetImage('assets/icons/heartbeat.png'),
            title: "Heartbeat",
            value: "No Recent Data",
            unit: "",
            color: Constants.lightGreen,
          ),
          CardMain(
              image: AssetImage('assets/icons/blooddrop.png'),
              title: "Blood\nPressure",
              value: "No Recent Data",
              unit: "",
              color: Constants.lightYellow)
        ],
      );
    }
  }
}

// Usage
// ListView(
//   scrollDirection: Axis.horizontal,
//   children: <Widget>[
//     CardMain(
//       image: AssetImage('assets/icons/heartbeat.png'),
//       title: "Hearbeat",
//       value: "66",
//       unit: "bpm",
//       color: Constants.lightGreen,
//     ),
//     CardMain(
//         image: AssetImage('assets/icons/blooddrop.png'),
//         title: "Blood Pressure",
//         value: "66/123",
//         unit: "mmHg",
//         color: Constants.lightYellow)
//   ],
// ),
class CardMain extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String value;
  final String unit;
  final Color color;

  CardMain(
      {Key? key,
      required this.image,
      required this.title,
      required this.value,
      required this.unit,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(right: 15.0),
        width: ((MediaQuery.of(context).size.width -
                (Constants.paddingSide * 2 + Constants.paddingSide / 2)) /
            2),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          color: color,
        ),
        child: Material(
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: ClipPath(
                    clipper: MyCustomClipper(clipType: ClipType.semiCircle),
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.black.withOpacity(0.03),
                      ),
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Icon and Hearbeat
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image(width: 32, height: 32, image: image),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 13, color: Constants.textDark),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Constants.textDark,
                        ),
                      ),
                      Text(
                        unit,
                        style:
                            TextStyle(fontSize: 15, color: Constants.textDark),
                      ),
                    ],
                  ),
                )
              ],
            ),
            onTap: () {
              debugPrint("CARD main clicked. redirect to details page");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailScreen()),
              );
            },
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
