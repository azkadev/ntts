// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";



class Voice extends JsonDart {

  
  Voice(super.rawData);
   
  static Map get defaultData {
    return {"@type":"voice","output_file":""};
  }

  
  String? get special_type {
    try {
      if (rawData["@type"] is String == false){
        return null;
      }
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }


  
  String? get output_file {
    try {
      if (rawData["output_file"] is String == false){
        return null;
      }
      return rawData["output_file"] as String;
    } catch (e) {
      return null;
    }
  }


  
  static Voice create({

    String? special_type,
    String? output_file,
})  {
    Voice voice = Voice({
  
      "@type": special_type,
      "output_file": output_file,


  });


return voice;

      }
}