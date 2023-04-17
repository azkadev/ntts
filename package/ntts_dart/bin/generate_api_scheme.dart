import 'dart:io';

import 'package:galaxeus_lib/galaxeus_lib.dart';
import "package:path/path.dart" as path;

void main(List<String> args) async {
  List<Map> scripts = [
    {
      "@type": "createVoice",
      "text": "",
      "exec_path": "",
      "model_path": "",
      "output_file": "",
      "speaker_id": 10,
    },
    {
      "@type": "getVersion", 
    },
  ];

  jsonToScripts(scripts, directory: Directory(path.join(Directory.current.path, "lib", "api")));
}
