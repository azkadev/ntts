// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";

class CreateVoice extends JsonDart {
  CreateVoice(super.rawData);

  static Map get defaultData {
    return {
      "@type": "createVoice",
      "text": "",
      "exec_path": "",
      "model_path": "",
      "output_file": "",
      "speaker_id": 10
    };
  }

  String? get special_type {
    try {
      if (rawData["@type"] is String == false) {
        return null;
      }
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }

  String? get text {
    try {
      if (rawData["text"] is String == false) {
        return null;
      }
      return rawData["text"] as String;
    } catch (e) {
      return null;
    }
  }

  String? get exec_path {
    try {
      if (rawData["exec_path"] is String == false) {
        return null;
      }
      return rawData["exec_path"] as String;
    } catch (e) {
      return null;
    }
  }

  String? get model_path {
    try {
      if (rawData["model_path"] is String == false) {
        return null;
      }
      return rawData["model_path"] as String;
    } catch (e) {
      return null;
    }
  }

  String? get output_file {
    try {
      if (rawData["output_file"] is String == false) {
        return null;
      }
      return rawData["output_file"] as String;
    } catch (e) {
      return null;
    }
  }

  int? get speaker_id {
    try {
      if (rawData["speaker_id"] is int == false) {
        return null;
      }
      return rawData["speaker_id"] as int;
    } catch (e) {
      return null;
    }
  }

  static CreateVoice create({
    String? special_type,
    String? text,
    String? exec_path,
    String? model_path,
    String? output_file,
    int? speaker_id,
  }) {
    CreateVoice createVoice = CreateVoice({
      "@type": special_type,
      "text": text,
      "exec_path": exec_path,
      "model_path": model_path,
      "output_file": output_file,
      "speaker_id": speaker_id,
    });

    return createVoice;
  }
}
