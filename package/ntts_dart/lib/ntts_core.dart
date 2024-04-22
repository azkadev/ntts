/* <!-- START LICENSE -->


Program Ini Di buat Oleh DEVELOPER Dari PERUSAHAAN GLOBAL CORPORATION 
Social Media: 

- Youtube: https://youtube.com/@Global_Corporation 
- Github: https://github.com/globalcorporation
- TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

Seluruh kode disini di buat 100% murni tanpa jiplak / mencuri kode lain jika ada akan ada link komment di baris code

Jika anda mau mengedit pastikan kredit ini tidak di hapus / di ganti!

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
import 'dart:convert';
import 'dart:ffi';
import 'dart:io'; 

import 'package:ffi/ffi.dart';  
import 'package:ntts_dart/typedef/request.dart';
import "package:ntts_dart/api/json_dart.dart" as json_dart_api;

import "package:ntts_dart/scheme/json_dart.dart" as json_dart_respond;
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

  Future<void> test({
    required Map data,
    String? pathLib,
  }) async {
    // Pointer<Utf8> data_native = json.encode(data).toNativeUtf8(); 
      // void request_result = library(pathLib: pathLib).lookupFunction<Void Function(), void Function()>("test", isLeaf: true).call();
    
    // malloc.free(data_native);
    // Map result = (json.decode(request_result.toDartString()) as Map);
    // malloc.free(request_result);
    return;
  }

  Map invokeRaw({
    required Map data,
    String? pathLib,
  }) {
    Pointer<Utf8> data_native = json.encode(data).toNativeUtf8();
    Pointer<Utf8> request_result = library(pathLib: pathLib).lookupFunction<RequestNative, RequestDart>("request").call(data_native);
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

  json_dart_respond.JsonDart request({
    required json_dart_api.JsonDart data,
    String? pathLib,
  }) {
    return json_dart_respond.JsonDart(
      requestRaw(
        data: data.toJson(),
        pathLib: pathLib,
      ),
    );
  }
}
