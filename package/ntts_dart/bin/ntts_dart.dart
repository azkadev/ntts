import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:ntts_dart/api/create_voice.dart';
import 'package:ntts_dart/ntts_dart.dart';
import 'package:ntts_dart/scheme/scheme.dart';
import 'package:play/play_dart.dart';
import "package:path/path.dart" as path;

void main(List<String> arguments) async {
  Args args = Args(arguments);
  Ntts ntts = Ntts(
    pathLib: "../../native_lib/build/lib/libntts.so",
  );
  File file = File(args.after("-m") ?? path.join(Directory.current.path, "en_US-libritts-high.onnx"));
  if (!file.existsSync()) {
    print("Please add model");
    exit(0);
  }

  File file_ouput = File(path.join(Directory.current.path, "data.wav"));
  if (file_ouput.existsSync()) {
    await file_ouput.delete();
  }
  var res = ntts.invokeRaw(
    data: CreateVoice.create(
      text: args.after("-t") ?? """
This sound is created using dart language by azkadev without using any internet

Human: Good afternoon, robot. How are you today?

Robot: I am functioning optimally, thank you. How may I assist you?

Human: I need help with my work. Can you help me sort out my emails?

Robot: Of course, I can help you with that. May I have access to your email account?

Human: Sure, let me give you access.

(After a few seconds)

Robot: I have access to your email account now. What do you want me to do?

Human: Can you sort out my emails by date?

Robot: Certainly. Sorting your emails by date. Please wait a moment.

(After a few seconds)

Robot: Your emails have been sorted by date. Is there anything else I can assist you with?

Human: Yes, can you also search for any important emails that contain the word "urgent"?

Robot: Understood. Searching for any emails containing the word "urgent".

(After a few seconds)

Robot: I have found several emails containing the word "urgent". Would you like me to prioritize them for you?

Human: Yes, please do.

Robot: Prioritizing urgent emails. Is there anything else I can assist you with?

Human: No, that's all for now. Thank you, robot.

Robot: You're welcome. Don't hesitate to contact me if you need further assistance.

""".trim(),
      model_path: file.path,
      output_file: file_ouput.path,
      speaker_id: int.tryParse(args.after("-s") ?? "0") ?? 10,
    ).toJson(),
  );

  Voice voice = Voice(res);

  Play play = Play();
  await play.open(medias: [
    voice.output_file ?? "",
  ]);
  play.player.stream.error.listen((event) {
    print(event);
  });
  // play.player.stream;
  play.player.stream.completed.listen(
    (event) {
      if (event) {
        exit(0);
      }
    },
    onDone: () {
      exit(0);
    },
  );

  // WhisperArgs whisperArgs = WhisperArgs([
  //   "m"
  // ]);
  // ntts.library().lookupFunction<whisper_request_native, whisper_request_dart>("test").call(whisperArgs.args.length, whisperArgs.toNativeList());
}
