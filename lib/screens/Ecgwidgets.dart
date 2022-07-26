import 'dart:ffi';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../utils/server.dart';
import '../utils/const_data.dart';

class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key? key, required this.result, this.onTap})
      : super(key: key);

  final ScanResult result;
  final VoidCallback? onTap;

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result.device.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            result.device.id.toString(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
    } else {
      return Text(result.device.id.toString());
    }
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.caption),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'
        .toUpperCase();
  }

  String getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add(
          '${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  String getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(context),
      leading: Text(result.rssi.toString()),
      trailing: RaisedButton(
        child: Text('CONNECT'),
        color: Colors.black,
        textColor: Colors.white,
        onPressed: (result.advertisementData.connectable) ? onTap : null,
      ),
      children: <Widget>[
        _buildAdvRow(
            context, 'Complete Local Name', result.advertisementData.localName),
        _buildAdvRow(context, 'Tx Power Level',
            '${result.advertisementData.txPowerLevel ?? 'N/A'}'),
        _buildAdvRow(context, 'Manufacturer Data',
            getNiceManufacturerData(result.advertisementData.manufacturerData)),
        _buildAdvRow(
            context,
            'Service UUIDs',
            (result.advertisementData.serviceUuids.isNotEmpty)
                ? result.advertisementData.serviceUuids.join(', ').toUpperCase()
                : 'N/A'),
        _buildAdvRow(context, 'Service Data',
            getNiceServiceData(result.advertisementData.serviceData)),
      ],
    );
  }
}

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile(
      {Key? key, required this.service, required this.characteristicTiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (service.uuid.toString().toUpperCase().substring(4,8)=='FFE0') {
      return ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           Text("ECG Measurement")
          ],
        ),
        children: characteristicTiles,
      );
    } else {
      return ListTile(
      );
    }
  }
}

var l = new List.empty(growable: true);
Text maa(String id) {
  var x = id;
  if (x == 'FFE1') {
    return Text("ECG");
  }
  else {
    return Text("");
  }
}
num b2int(List<int> bytes) {
  num value = 0;

  for (var i = 0, length = bytes.length; i<length; i++) {
    value += bytes[i] * pow(256, i);
  }
  return value;
}

class CharacteristicTile extends StatelessWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;
  final VoidCallback? onNotificationPressed;
  FirebaseFirestore fbfs = FirebaseFirestore.instance;
  var sTime = DateTime.now();
  CharacteristicTile(
      {Key? key,
        required this.characteristic,
        required this.descriptorTiles,
        this.onReadPressed,
        this.onWritePressed,
        this.onNotificationPressed})
      : super(key: key);



  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<int>>(

      stream: characteristic.value,
      initialData: characteristic.lastValue,
      builder: (c, snapshot) {
        final value = snapshot.data;
        Int8List a = Int8List.fromList(value!);
        // int aa = a.asByteArray().getint32(0);
        List<int> aa = List.from(a);
        l.add(b2int(aa));

        return ExpansionTile(
          title: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                maa(characteristic.uuid.toString().toUpperCase().substring(4,8)),
                // Text(value.toString()),
                Text(l.toString()),

              ],

            ),

            trailing: Row(

              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed:
                  onNotificationPressed
                  , child: Text("측정"),

                ),
                TextButton(onPressed: (){
                  l = [];
                }, child: Text("Reset"),
                ),TextButton(onPressed: (){

                  // fbfs.collection("ECG")
                  //     .add({
                  //   'stime':sTime,
                  //   'etime':DateTime.now(),
                  //   'ecg': l,'class':'측정중'});
                  server.addDB_getReq(
                      fbfs,
                      {
                        'etime': sTime,
                        'stime': DateTime.now(),
                        'ecg': ecg_list,
                        'class': '측정중'
                      },
                      "ECG");
                }, child: Text("저장"),
                ),


              ],
            ),

            contentPadding: EdgeInsets.all(0.0),
          ),
          // trailing: Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     IconButton(
          //       icon: Icon(
          //           characteristic.isNotifying
          //               ? Icons.sync_disabled
          //               : Icons.sync,
          //           color: Theme.of(context).iconTheme.color?.withOpacity(1)),
          //       onPressed: onNotificationPressed,
          //
          //     ),
          //   ],
          // ),
          // children: descriptorTiles,
        );
      },
    );
  }
}

class DescriptorTile extends StatelessWidget {
  final BluetoothDescriptor descriptor;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;

  const DescriptorTile(
      {Key? key,
        required this.descriptor,
        this.onReadPressed,
        this.onWritePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Descriptor'),
          Text('0x${descriptor.uuid.toString().toUpperCase()}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Theme.of(context).textTheme.caption?.color))
        ],
      ),
      subtitle: StreamBuilder<List<int>>(
        stream: descriptor.value,
        initialData: descriptor.lastValue,
        builder: (c, snapshot) => Text(snapshot.data.toString()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_download,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onReadPressed,
          ),
          IconButton(
              icon: Icon(
                Icons.file_upload,
                color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
              ),
              onPressed: onWritePressed
          ),
        ],
      ),
    );
  }
}

class AdapterStateTile extends StatelessWidget {
  const AdapterStateTile({Key? key, required this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: ListTile(
        title: Text(
          'Bluetooth adapter is ${state.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.subtitle1,
        ),
        trailing: Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.subtitle1?.color,
        ),
      ),
    );
  }
}
