import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Counter {
  Counter() {
    _readCount().then((count) => _count.value = count);
  }

  ValueNotifier<int> _count = ValueNotifier(0);

  ValueListenable<int> get count => _count;

  void increment() {
    _count.value++;
    _writeCount(_count.value);
  }

  Future<int> _readCount() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt('Counter.count') ?? 0;
  }

  Future<void> _writeCount(int count) async {
    var prefs = await SharedPreferences.getInstance();
    BeaconBroadcast beaconBroadcast = BeaconBroadcast();
    beaconBroadcast
        .setUUID('39ED98FF-2900-441A-802F-9C398FC199D2')
        .setMajorId(1)
        .setMinorId(100)
        .start();

    // beaconBroadcast
    //     .setUUID('39ED98FF-2900-441A-802F-9C398FC199D2')
    //     .setMajorId(1)
    //     .setMinorId(100)
    //     .setTransmissionPower(-59) //optional
    //     .setIdentifier('com.example.myDeviceRegion') //iOS-only, optional
    //     .setLayout('m:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24')
    //     .setManufacturerId(0x004C)
    //     .start();

    return prefs.setInt('Counter.count', count);
  }
}
