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
    String special_type = "createVoice",
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
