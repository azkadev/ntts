import 'dart:io';
import 'dart:isolate';

import 'package:general_lib/general_lib.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:ntts_dart/api/create_voice.dart';
import 'package:ntts_dart/ntts_dart.dart';
import 'package:ntts_dart/scheme/scheme.dart';
import 'package:play/play_dart.dart';
import "package:path/path.dart" as path;

void main(List<String> arguments) async {
  Logger logger = Logger();
  logger.info("Started NTTS DART - AZKADEV");
  Args args = Args(arguments);
  String file_model = args.after("-m") ?? path.join(Directory.current.path, "en_US-libritts-high.onnx");
  Progress progress_load_model = logger.progress("Load Model");
  int speaker_id = int.tryParse(args.after("-s") ?? "10") ?? 10;
  String text = args.after("-t") ??
      """
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

"""
          .trim();
  await Future.delayed(Duration(milliseconds: 500));
  File file = File(file_model);
  String file_model_path = file.path;
  progress_load_model.update("Check Model File: ${file.path}");
  await Future.delayed(Duration(milliseconds: 500));
  if (!file.existsSync()) {
    progress_load_model.fail("Not Found Model File: ${file.path}");
    await Future.delayed(Duration(milliseconds: 500));
    exit(0);
  } else {
    progress_load_model.complete("Found Model File: ${file.path}");
    await Future.delayed(Duration(milliseconds: 500));
  }

  File file_ouput = File(path.join(Directory.current.path, "data.wav"));
  String file_output_sound = file_ouput.path;
  if (file_ouput.existsSync()) {
    await file_ouput.delete();
  }

  Progress progress_create_sound = logger.progress("Create Sound");
  await Future.delayed(Duration(milliseconds: 500));
  var res = await Isolate.run<Map>(() {
    Ntts ntts = Ntts(
      pathLib: "libntts.so",
    );

    var res = ntts.invokeRaw(
      data: CreateVoice.create(
        text: text,
        model_path: file_model_path,
        output_file: file_output_sound,
        speaker_id: speaker_id,
      ).toJson(),
    );

    return res;
  });
  await Future.delayed(Duration(milliseconds: 500));
  progress_create_sound.complete("Succes Create Sound");
  await Future.delayed(Duration(milliseconds: 500));
  Voice voice = Voice(res);
  Progress progress_play_sound = logger.progress("Started Play Sound");
  Play play = Play();

  await Future.delayed(Duration(milliseconds: 500));
  await play.open(
    medias: [
      voice.output_file ?? "",
    ],
    play: false,
  );

  await play.play();
  // play.player.stream;
  play.player.stream.completed.listen(
    (event) async {
      if (event) {
        progress_play_sound.complete("Finished");
        await Future.delayed(Duration(seconds: 2));
        exit(0);
      }
    },
    onDone: () async {
      progress_play_sound.complete("Finished");
      await Future.delayed(Duration(seconds: 2));
      exit(0);
    },
  );
}
