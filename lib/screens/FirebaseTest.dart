import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:goh/utils/const_data.dart';

class FirebaseTest extends StatefulWidget {
  @override
  _FirebaseTest createState() => _FirebaseTest();
}

class _FirebaseTest extends State<FirebaseTest> {
  bool isLoading = false;
  FirebaseFirestore fbfs = FirebaseFirestore.instance;
  // Firestore firestore = Firestore.instance;

  Future<void> init(String collection) async {
    FirebaseFirestore.instance
        .collection(collection)
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        log("id : ${element.data()['page']}");
        log("title : ${element.data()['purchase']}");
        log("image : ${element.data()['title']}");
        // log("view : ${element.data()['view']}");
      });
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // init('books');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("hello world"),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                FlatButton(
                    color: Colors.blue,
                    child: Text("hi"),
                    onPressed: () {
                      
                      fbfs
                          .collection("ECG")
                          .add({'datetime': DateTime.now(), 'ecg': ecg_list,'class':''});
                      fbfs.collection("BP").add({
                        'datetime': DateTime.now(),
                        'pulse': "30",
                        'bp': "140/50"
                      });

                      print("hi");
                      fbfs
                          .collection("books")
                          .doc('on_intelligence')
                          .get()
                          .then((DocumentSnapshot ds) {
                        Map<String, dynamic>? m =
                            ds.data() as Map<String, dynamic>?;
                        print(m);
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
