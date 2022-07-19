import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class AssetsStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<String> getFromCSV() async {
    print('hi');
    final filename = new File(
            "'/Users/0hyun/Desktop/flutter/flutter_test_proj/goh/goh/assets/icons/data.csv'")
        .readAsStringSync();
    print(filename);
    return filename;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print('hi');
    // var a = await rootBundle.load('/assets/data.csv');
    // print(a);
    print('$path');
    print(path.runtimeType);
    // getApplicationDocumentsDirectory.
    print(File(
            '/Users/0hyun/Desktop/flutter/flutter_test_proj/goh/goh/assets/icons/data.csv')
        .exists());

    return File(
        '/Users/0hyun/Desktop/flutter/flutter_test_proj/goh/goh/assets/icons/data.csv');
  }

  Future<String> readCsv() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }
}
