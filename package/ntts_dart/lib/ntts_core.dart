import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:ntts_dart/ntts_request.dart';
import 'package:ntts_dart/ntts_response.dart';
import 'package:ntts_dart/typedef/request.dart';

class Ntts {
  String path_lib = "libntts.so";
  bool is_cli;
  Ntts({
    this.is_cli = false,
    String? pathLib,
  }) {
    if (pathLib != null) {
      path_lib = pathLib;
    }
  }

  DynamicLibrary library({
    String? pathLib,
  }) {
    pathLib ??= path_lib;
    if (Platform.isIOS || Platform.isMacOS) {
      if (is_cli) {
        return DynamicLibrary.open(path_lib);
      }
      return DynamicLibrary.process();
    } else {
      return DynamicLibrary.open(pathLib);
    }
  }

  Map invokeRaw({
    required Map data,
    String? pathLib,
  }) {
    Pointer<Utf8> data_native = json.encode(data).toNativeUtf8();
    Pointer<Utf8> request_result = library(pathLib: pathLib)
        .lookupFunction<RequestNative, RequestDart>("request")
        .call(data_native);
    malloc.free(data_native);
    Map result = (json.decode(request_result.toDartString()) as Map);
    malloc.free(request_result);
    return result;
  }

  Map requestRaw({
    required Map data,
    String? pathLib,
  }) {
    return invokeRaw(data: data, pathLib: pathLib);
  }

  NttsResponse request({
    required NttsRequest nttsRequest,
    String? pathLib,
  }) {
    return NttsResponse(
      requestRaw(
        data: nttsRequest.toJson(),
        pathLib: pathLib,
      ),
    );
  }
}
