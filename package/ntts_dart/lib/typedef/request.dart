
import 'dart:ffi';

import 'package:ffi/ffi.dart';

typedef RequestNative = Pointer<Utf8> Function(Pointer<Utf8> data);
typedef RequestDart = Pointer<Utf8> Function(Pointer<Utf8> data);
