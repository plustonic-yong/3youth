import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:io';
import 'package:goh/utils/const_data.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

class GraphPageSample extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  GraphPageSample({super.key});
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPageSample> {
  late List<SalesData> _chartData;
  late TooltipBehavior _tooltipBehavior;
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
    _chartData = getChartData();
    return Container(
        child: SfCartesianChart(
      title: ChartTitle(text: 'ECG Data'),
      legend: Legend(isVisible: true, position: LegendPosition.top),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        LineSeries<SalesData, double>(
            name: 'ECG data',
            dataSource: _chartData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            // dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true)
      ],
      primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        isVisible: true,
      ),
      primaryYAxis: NumericAxis(
        // labelFormat: '{value}',
        isVisible: false,
      ),
    ));
  }

  List<SalesData> getChartData({String? filename}) {
    // var a = _filename!.split("");
    // if (filename != '') {
    //   // var a = filename.split(" ");
    //   // print(a.runtimeType);
    //   // List<int> lint = a.map(int.parse).toList();
    //   // print(lint);
    //   // var aa = [for (var li in a) int.parse(li)];
    //   // print(aa.runtimeType);
    //   var a = filename?.split("\n");
    //   List<double>? lint = a?.map(double.parse).toList();
    //   final aa = lint!.asMap();
    //   print(aa.runtimeType);
    //   final List<SalesData> chartData = [];
    //   aa.forEach(
    //       (key, value) => chartData.add(SalesData(key.toDouble(), value)));
    //   print(chartData.length);
    //   return chartData;
    //   //  = [for (var i )]
    // }
    final List<SalesData> chartData = [];
    ecg_list.asMap().forEach((key, value) => { 
      chartData.add(SalesData(key.toDouble(),value.toDouble()))});
    // final List<SalesData> chartData = [
    //   SalesData(2017, 25),
    //   SalesData(2018, 12),
    //   SalesData(2019, 24),
    //   SalesData(2020, 18),
    //   SalesData(2021, 30)
    // ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
