import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:goh/utils/const.dart';

class TableBasicsExample extends StatefulWidget {
  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class _TableBasicsExampleState extends State<TableBasicsExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final db = FirebaseFirestore.instance;

  Widget personDetailCard() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/icons/heartbeat.png'),
                        ))),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "hi",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'Person.bio',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return StreamBuilder<QuerySnapshot>(
        stream: db.collection('ECG').orderBy('datetime').snapshots(),
        builder: (context, snapshotECG) {
          Map<String, dynamic>? dataLatestECG =
              snapshotECG.data?.docs.last.data() as Map<String, dynamic>?;
          bool isLoadingECG = !snapshotECG.hasData;
          print(snapshotECG);
          return StreamBuilder<QuerySnapshot>(
              stream: db.collection('BP').orderBy('datetime').snapshots(),
              builder: (context, snapshotBP) {
                Map<String, dynamic>? dataLatestBP =
                    snapshotBP.data?.docs.last.data() as Map<String, dynamic>?;
                bool isLoadingBP = !snapshotBP.hasData;
                return isLoadingBP
                    ? Stack()
                    : Stack(
                        // appBar: AppBar(
                        //   // title: Text('TableCalendar - Basics'),
                        //   backgroundColor: Theme.of(context).accentColor,
                        // ),
                        children: <Widget>[
                            ClipPath(
                              // clipper: MyCustomClipper(clipType: ClipType.bottom),
                              child: Container(
                                color: Theme.of(context).accentColor,
                                height: Constants.headerHeight * 0.3,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(Constants.paddingSide),
                                child: ListView(children: <Widget>[
                                  //   Row(
                                  //     children: <Widget>[
                                  //       Expanded(
                                  //     child: Text(
                                  //       "Lee Yu Gyung님",
                                  //       style: TextStyle(
                                  //           fontSize: 25,
                                  //           fontWeight: FontWeight.w900,
                                  //           color: Colors.white),
                                  //     ),
                                  //   ),
                                  //   CircleAvatar(
                                  //       radius: 25.0,
                                  //       backgroundImage:
                                  //           AssetImage('assets/icons/woman.png'))
                                  // ],
                                  // ),

                                  SizedBox(
                                      height: Constants.headerHeight * 0.03),
                                  Container(
                                      child: TableCalendar(
                                    firstDay: kFirstDay,
                                    lastDay: kLastDay,
                                    focusedDay: _focusedDay,
                                    calendarFormat: _calendarFormat,
                                    selectedDayPredicate: (day) {
                                      // Use `selectedDayPredicate` to determine which day is currently selected.
                                      // If this returns true, then `day` will be marked as selected.

                                      // Using `isSameDay` is recommended to disregard
                                      // the time-part of compared DateTime objects.
                                      return isSameDay(_selectedDay, day);
                                    },
                                    onDaySelected: (selectedDay, focusedDay) {
                                      if (!isSameDay(
                                          _selectedDay, selectedDay)) {
                                        // Call `setState()` when updating the selected day
                                        setState(() {
                                          _selectedDay = selectedDay;
                                          _focusedDay = focusedDay;
                                        });
                                      }
                                    },
                                    onFormatChanged: (format) {
                                      if (_calendarFormat != format) {
                                        // Call `setState()` when updating calendar format
                                        setState(() {
                                          _calendarFormat = format;
                                        });
                                      }
                                    },
                                    onPageChanged: (focusedDay) {
                                      // No need to call `setState()` here
                                      _focusedDay = focusedDay;
                                    },
                                  )),
                                  Container(
                                    child: (isLoadingBP)
                                        ? Container()
                                        : Column(
                                            children: List<Widget>.from(
                                                snapshotBP.data!.docs.map((e) =>
                                                    personDetailCard()))),
                                  )
                                ])),
                          ]);
              });
        });
  }
}
