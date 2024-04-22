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
import 'package:galaxeus_lib/galaxeus_lib.dart';

enum ValidationDataType {
  username,
  phone_number,
  password,
  code,
  reason,
}

class ValidationData {
  bool is_valid = false;
  String? message;
  ValidationData({
    required this.is_valid,
  });
}

ValidationData validation({
  required String? data,
  required ValidationDataType validationDataType,
}) {
  ValidationData validationData = ValidationData(
    is_valid: false,
  );
  if (validationDataType == ValidationDataType.code) {
    if (data != null) {
      if (!RegExp(r"^([0-9]+)$", caseSensitive: false).hashData(data)) {
        validationData.message = "Format Code Salah";
      } else if (data.length != 5) {
        validationData.message = "Panjang code harus 5";
      } else {
        validationData.is_valid = true;
      }
    } else {
      validationData.message = "Code harus ada";
    }
  }
  if (validationDataType == ValidationDataType.username) {
    if (data != null) {
      if (!RegExp(r"^([a-z]+)$", caseSensitive: false).hashData(data)) {
        validationData.message = "Format Username Salah";
      } else if (data.length < 5) {
        validationData.message = "Minimal Username 5";
      } else if (data.length > 25) {
        validationData.message = "Maximal username 25";
      } else if (RegExp(r"(kontol|memek|anjing|bangsat)", caseSensitive: false)
          .hashData(data)) {
        validationData.message = "Username tidak boleh mengandung kata kasar";
      } else {
        validationData.is_valid = true;
      }
    } else {
      validationData.message = "Username harus ada";
    }
  }
  if (validationDataType == ValidationDataType.password) {
    if (data != null) {
      if (data.length < 5) {
        validationData.message = "Minimal Password 5";
      } else if (data.length > 50) {
        validationData.message = "Maximal Password 50";
      } else if (!RegExp(r"([a-z]+)", caseSensitive: false).hashData(data)) {
        validationData.message = "Password harus ada huruf";
      } else if (!RegExp(r"([0-9]+)", caseSensitive: false).hashData(data)) {
        validationData.message = "Password harus ada angka";
      } else if (!RegExp(r"([./,\\=\-+?><;:'\]\[|}{_)(*&^%$#@!~`]+)",
              caseSensitive: false)
          .hashData(data)) {
        validationData.message = "Password harus ada simbol";
      } else if (!RegExp(r"([ ]+)", caseSensitive: false).hashData(data)) {
        validationData.message = "Password harus ada space";
      } else if (RegExp(r"(kontol|memek|anjing|bangsat)", caseSensitive: false)
          .hashData(data)) {
        validationData.message = "Password tidak boleh mengandung kata kasar";
      } else {
        validationData.is_valid = true;
      }
    } else {
      validationData.message = "Password harus ada";
    }
  }

  if (validationDataType == ValidationDataType.reason) {
    if (data != null) {
      if (data.length < 50) {
        validationData.message = "Minimal Reason 50";
      } else if (data.length > 250) {
        validationData.message = "Maximal Reason 250";
      } else {
        validationData.is_valid = true;
      }
    } else {
      validationData.message = "Reason harus ada";
    }
  }
  return validationData;
}
