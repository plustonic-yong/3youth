import 'package:flutter/material.dart';
import 'package:goh/screens/auth/sign_in.dart';
import 'package:goh/utils/const.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() => print("hi");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         // Remove the debug banner
//         debugShowCheckedModeBanner: false,
//         title: 'KindaCode.com',
//         theme: ThemeData(
//           primarySwatch: Colors.indigo,
//         ),
//         home: MyHomePage());
//   }
// }

// class MyHomePage extends StatelessWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   // Generate some dummy data for the cahrt
//   // This will be used to draw the red line
//   final List<FlSpot> dummyData1 = List.generate(8, (index) {
//     return FlSpot(index.toDouble(), index * Random().nextDouble());
//   });

//   // This will be used to draw the orange line
//   final List<FlSpot> dummyData2 = List.generate(8, (index) {
//     return FlSpot(index.toDouble(), index * Random().nextDouble());
//   });

//   // This will be used to draw the blue line
//   final List<FlSpot> dummyData3 = List.generate(8, (index) {
//     return FlSpot(index.toDouble(), index * Random().nextDouble());
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           width: double.infinity,
//           child: LineChart(
//             LineChartData(
//               borderData: FlBorderData(show: false),
//               lineBarsData: [
//                 // The red line
//                 LineChartBarData(
//                   spots: dummyData1,
//                   isCurved: true,
//                   barWidth: 3,
//                   color: Colors.red,
//                 ),
//                 // The orange line
//                 LineChartBarData(
//                   spots: dummyData2,
//                   isCurved: true,
//                   barWidth: 3,
//                   color:Colors.orange
//                 ),
//                 // The blue line
//                 LineChartBarData(
//                   spots: dummyData3,
//                   isCurved: false,
//                   barWidth: 3,
//                   color:
//                     Colors.blue
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: Constants.lighTheme(context),
      debugShowCheckedModeBanner: false,
      // home: FirebaseTest(),
      home: const SignInScreen(),
    );
  }
}

// PlatformFile? selectedFile;
// Future selectCSVFile() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       withData: true,
//       type: FileType.custom,
//       allowedExtensions: ['csv']);

//   if (result != null) {
//     selectedFile = result.files.first;
//   } else {
//     selectedFile = null;
//   }
// }
