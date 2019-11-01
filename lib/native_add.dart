import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/services.dart';

class NativeAdd {
  static const MethodChannel _channel = const MethodChannel('native_add');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static int add(int a, int b) {
    return nativeAdd(a, b);
  }
}

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("libnative_add.so")
    : DynamicLibrary.open("native_add.framework/native_add");

final int Function(int x, int y) nativeAdd = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();
