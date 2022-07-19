import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:goh/screens/Ecgmain.dart';
import 'package:goh/utils/const.dart';

import '../screens/Bpmain.dart';

class MultiFloatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SpeedDial(animatedIcon: AnimatedIcons.menu_close,

        // activeIcon: Image.asset("assets/icons/heartbeat.png"),
        // child:Image.asset('assets/icons/heartbeat.png',
        // height: _icon_size + 3 , color: Colors.white),
        children: [
          SpeedDialChild(
            child: Image.asset('assets/icons/blooddrop.png',
                height: Constants.iconSize * 0.9, color: Colors.black),
            //Icon(Icons.chrome_reader_mode, color: Colors.black),
            backgroundColor: Colors.white,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BpMain()),
            ),
            label: 'Blood Pressure',
            labelStyle:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
            labelBackgroundColor: Colors.white,
          ),
          SpeedDialChild(
            child: Icon(Icons.monitor_heart_outlined, color: Colors.black),
            //Image.asset('assets/icons/heartbeat.png',
            // height: _icon_size * 0.9, color: Colors.black),
            //Icon(Icons.create, color: Colors.black),
            backgroundColor: Colors.white,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Ecg()),
            ),
            label: 'ECG',
            labelStyle:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
            labelBackgroundColor: Colors.white,
          ),
        ]);
  }
}
