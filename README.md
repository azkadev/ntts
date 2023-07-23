# Neural Text To Speech

Neural Text To Speech Library untuk menghasilkan suara realistis seperti natural di bahasa dart, neural text to speech ini berjalan tanpa perlu koneksi internet dan hanya membutuhkan cpu saja

### Demo

[![](https://raw.githubusercontent.com/azkadev/ntts_dart/main/.github/youtube_ntts.jpg)](https://youtu.be/IfOJs7OUH8o)


https://user-images.githubusercontent.com/82513502/232475337-c02e24fd-52a7-4a4a-933c-b8f69aeedb5b.mp4

---


## More Update And More Features?

Indonesia: jika anda ingin saya maintance terus project ini silahkan [donate ke saya](https://github.com/sponsors/azkadev)
<br>
English: if you want me to continue to maintain this project please [donate to me](https://github.com/sponsors/azkadev)

 

### TESTED ON

| NO | OS                  | CPU                 | RAM |
|----|---------------------|---------------------|-----|
| 1  | Ubuntu 22.04        | AMD RYZEN 5500U     | 8GB |
| 2  | Ubuntu Server 22.04 | Intel Celeron n2940 | 4GB |


### Resources

| No | Name                                                                                                            |
|----|-----------------------------------------------------------------------------------------------------------------|
| 1  | [MODEL TTS ENGLISH](https://github.com/rhasspy/piper/releases/download/v0.0.2/voice-en-us-libritts-high.tar.gz) |


### Dependencies

```bash
sudo apt-get install espeak-ng mpv
```

```bash
sudo apt-get install gawk bison gcc make -y
wget -c https://ftp.gnu.org/gnu/glibc/glibc-2.33.tar.gz
tar -zxvf glibc-2.33.tar.gz && cd glibc-2.33
mkdir glibc-build && cd glibc-build
../configure --prefix=/opt/glibc
make
sudo make install
```


### Installation
```bash

# download model
wget https://huggingface.co/rhasspy/piper-voices/blob/v1.0.0/en/en_US/libritts/high/en_US-libritts-high.onnx
wget https://huggingface.co/rhasspy/piper-voices/blob/v1.0.0/en/en_US/libritts/high/en_US-libritts-high.onnx.json

# download ntts
wget https://github.com/azkadev/ntts/releases/download/latest/ntts_dart.deb

# install ntts
sudo dpkg --force-all -i ./ntts_dart.deb

# try ntts
ntts_dart -m "en_US-libritts-high.onnx" -t "Hello World"
```

### Development

```bash
git clone https://github.com/azkadev/ntts_dart.git
cd ntts_dart
```


### Compile Library

```bash
cd native_lib
mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
```


### Install

```bash
dart pub add ntts_dart
```

### Import Library

```bash
import 'package:ntts_dart/ntts_dart.dart';
```


### Quickstart

Sebelum di run pastikan kamu sudah mengcompile library dan menyiapkan model dahulu

```dart
import 'dart:io';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:ntts_dart/api/create_voice.dart';
import 'package:ntts_dart/ntts_dart.dart';
import 'package:ntts_dart/scheme/scheme.dart';
import 'package:play/play_dart.dart';
import "package:path/path.dart" as path;

void main(List<String> arguments) async {
  Args args = Args(arguments);
  Ntts ntts = Ntts(
    pathLib: "libntts.so",
  );
  File file = File(path.join(Directory.current.path, "en_US-libritts-high.onnx"));
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
      text: """
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
          .trim(),
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
}

```

### Refferensi

1. [Piper](https://github.com/rhasspy/piper)
2. [Mimic Recording Studio](https://github.com/MycroftAI/mimic-recording-studio)
3. [Espeak](https://github.com/espeak-ng/espeak-ng)
4. [onnxruntime](https://github.com/microsoft/onnxruntime)

 