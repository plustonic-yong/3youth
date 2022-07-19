import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goh/utils/const_data.dart';

class DBTest{
  final db = FirebaseFirestore.instance;

  void addData(collection){
    db
    .collection(collection)
    .add({'datetime': DateTime.now(), 'ecg': ecg_list,'class':''});
                      db.collection("BP").add({
                        'datetime': DateTime.now(),
                        'pulse': "30",
                        'bp': "140/50"
                      });
  }
}