#include <chrono>
#include <condition_variable>
#include <filesystem>
#include <fstream>
#include <functional>
#include <iostream>
#include <mutex>
#include <sstream>
#include <stdexcept>
#include <string>
#include <thread>
#include <vector>

#ifdef _MSC_VER
#define WIN32_LEAN_AND_MEAN
#define NOMINMAX
#include <windows.h>
#endif

#ifdef __APPLE__
#include <mach-o/dyld.h>
#endif

// #include <spdlog/sinks/stdout_color_sinks.h>
// #include <spdlog/spdlog.h>

#include "json.hpp"
#include "piper.hpp"

using namespace std;
using json = nlohmann::json;

enum OutputType { OUTPUT_FILE, OUTPUT_DIRECTORY, OUTPUT_STDOUT, OUTPUT_RAW };

struct RunConfig {
  // Path to .onnx voice file
  filesystem::path modelPath;

  // Path to JSON voice config file
  filesystem::path modelConfigPath;

  // Type of output to produce.
  // Default is to write a WAV file in the current directory.
  OutputType outputType = OUTPUT_DIRECTORY;

  // Path for output
  optional<filesystem::path> outputPath = filesystem::path(".");

  // Numerical id of the default speaker (multi-speaker voices)
  optional<piper::SpeakerId> speakerId;

  // Amount of noise to add during audio generation
  optional<float> noiseScale;

  // Speed of speaking (1 = normal, < 1 is faster, > 1 is slower)
  optional<float> lengthScale;

  // Variation in phoneme lengths
  optional<float> noiseW;

  // Seconds of silence to add after each sentence
  optional<float> sentenceSilenceSeconds;

  // Path to espeak-ng data directory (default is next to piper executable)
  optional<filesystem::path> eSpeakDataPath;

  // Path to libtashkeel ort model
  // https://github.com/mush42/libtashkeel/
  optional<filesystem::path> tashkeelModelPath;

  // stdin input is lines of JSON instead of text with format:
  // {
  //   "text": str,               (required)
  //   "speaker_id": int,         (optional)
  //   "speaker": str,            (optional)
  //   "output_file": str,        (optional)
  // }
  bool jsonInput = false;
};


json createVoice(json jsonData) {
  json jsonRespond;
  jsonRespond["@type"] = "voice";

  RunConfig runConfig;

  // spdlog::set_default_logger(spdlog::stderr_color_st("piper"));

  piper::PiperConfig piperConfig;
  piper::Voice voice;

  string model_path = jsonData["model_path"];
  auto startTime = chrono::steady_clock::now();
  // (piper::SpeakerId)stol("");

  runConfig.speakerId = (piper::SpeakerId)stol(to_string(jsonData["speaker_id"]));
  loadVoice(piperConfig, model_path, model_path + ".json", voice, (runConfig.speakerId));
  auto endTime = chrono::steady_clock::now();


  // "@type": "createVoice",
  // "text": "",
  // "exec_path": "",
  // "model_path": "",
  // "output_file": "",
  // "speaker_id": 10,

  auto exePath = filesystem::canonical("/proc/self/exe");


  if (voice.phonemizeConfig.phonemeType == piper::eSpeakPhonemes) {

    // piperConfig.eSpeakDataPath = "/home/galaxeus/Documents/hexaminate/app/ntts/native_lib/build/espeak-ng-data";

    piperConfig.eSpeakDataPath =
      std::filesystem::absolute(
        exePath.parent_path().append("espeak-ng-data"))
      .string();

    // spdlog::debug("espeak-ng-data directory is expected at {}",
      // piperConfig.eSpeakDataPath);
  } else {
    // Not using eSpeak
    piperConfig.useESpeak = false;
  }


  piper::initialize(piperConfig);



  string line = jsonData["text"];
  piper::SynthesisResult result;
  auto speakerId = voice.synthesisConfig.speakerId;


  const auto now = chrono::system_clock::now();
  const auto timestamp = chrono::duration_cast<chrono::nanoseconds>(now.time_since_epoch()).count();


  // Output audio to WAV file
  ofstream audioFile(jsonData["output_file"], ios::binary);
  piper::textToWavFile(piperConfig, voice, line, audioFile, result);


  voice.synthesisConfig.speakerId = speakerId;
  jsonRespond["output_file"] = jsonData["output_file"];


  piper::terminate(piperConfig);


  return jsonRespond;


}



char* jsonToChar(json jsonData) {
  std::string result = jsonData.dump();
  char* ch = new char[result.size() + 1];
  strcpy(ch, result.c_str());
  return ch;
}

std::string charToString(char* value) {
  std::string result(value);
  return result;
}

char* stringToChar(std::string value) {
  char* ch = new char[value.size() + 1];
  strcpy(ch, value.c_str());
  return ch;
}

extern "C"
{
  void print(char* value) {
    std::cout << charToString(value) << std::endl;
  }
  int calculate(int num_1, int num_2) {
    return num_1 * num_2;
  }
  char* request(char* data) {
    json jsonBody = json::parse(data);

    json jsonResult;
    if (jsonBody["@type"] == "createVoice") {

      // "@type": "createVoice",
      // "text": "",
      // "exec_path": "",
      // "model_path": "",
      // "output_file": "",
      // "speaker_id": 10,
      return jsonToChar(createVoice(jsonBody));
    }


    if (jsonBody["@type"] == "getVersion") {
      jsonResult["@type"] = "version";
      jsonResult["message"] = "version lib v0.0.0";
      return jsonToChar(jsonResult);
    }
    jsonResult["@type"] = "error";
    jsonResult["message"] = "method not found";
    return jsonToChar(jsonResult);
  }


}