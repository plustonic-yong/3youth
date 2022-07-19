import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BPChart extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  BPChart({Key? key}) {}

  // Generate some dummy data for the cahrt
  // This will be used to draw the red line
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the orange line
  final List<FlSpot> dummyData2 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the blue line
  final List<FlSpot> dummyData3 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: db.collection('BP').orderBy('datetime').snapshots(),
        builder: (context, snapshotBP) {
          
          List<FlSpot> s_bp = [];
          List<FlSpot> d_bp = [];
          int idx = 0;
          for (var a in snapshotBP.data!.docs.reversed) {
            var val = a['bp'].split('/');
            s_bp.add(FlSpot(
                idx.toDouble(),
                double.parse(val[0])));
            d_bp.add(FlSpot(
                idx.toDouble(),
                double.parse(val[1])));
            idx += 1;
            
          }

          return Container(
              width: double.infinity,
              height: double.infinity,
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(), 
                    leftTitles: AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        interval: 3,
                    )),
                    ),
                  lineBarsData: [
                    // The red line
                    LineChartBarData(
                      spots: s_bp,
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.red,
                    ),
                    // The orange line
                    LineChartBarData(
                        show: false,
                        spots: dummyData2,
                        isCurved: true,
                        barWidth: 3,
                        color: Colors.orange),
                    // The blue line
                    LineChartBarData(
                        spots: d_bp,
                        isCurved: false,
                        barWidth: 3,
                        color: Colors.blue)
                  ],
                ),
              ));
        });
  }
}
