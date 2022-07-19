import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:goh/utils/const.dart';
import 'package:http/http.dart';

const _API_PREFIX = "https://google.com";

class Server {
  Dio dio = new Dio();
  Server() {
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['charset'] = 'UTF-8';
    dio.options.headers['Accept'] = '*/*';
  }

  Future<void> getReq() async {
    var response = await dio.get("$_API_PREFIX");
    print(response.data.toString());
  }

  Future<void> postReq(db, data, uri, documentId, table) async {
    var response = await dio.post("$ML_API_URL/$uri", data: data);
    print(response.data);
    db
        .collection('$table')
        .doc(documentId)
        .update({'class': response.data['result']});
  }
  void addDB_getReq(db, data, table) {
    var req_data;
    if (table == 'BP') {
      req_data = {};
      req_data['age'] = 3;
      var splt = data['bp'].split('/');
      req_data['s_bp'] = splt[0];
      req_data['d_bp'] = splt[1];
    } else {
      req_data = data['ecg'];
    }
    db.collection("$table").add(data).then((value) => {server.postReq(db, req_data, table.toLowerCase(), value.id, table)});


  }
}

Server server = new Server();
