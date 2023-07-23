# Neural Text To Speech

Neural Text To Speech Library untuk menghasilkan suara realistis seperti natural di bahasa dart, neural text to speech ini berjalan tanpa perlu koneksi internet dan hanya membutuhkan cpu saja

### Demo

[![](https://raw.githubusercontent.com/azkadev/ntts_dart/main/.github/youtube_ntts.jpg)](https://youtu.be/IfOJs7OUH8o)


https://user-images.githubusercontent.com/82513502/232475337-c02e24fd-52a7-4a4a-933c-b8f69aeedb5b.mp4

---


## More Update And More Features?

Indonesia: jika anda ingin saya maintance terus project ini silahkan donate ke saya
English: if you want me to continue to maintain this project please donate to me


### Information

Library ini sudah tidak akftif maintance jika anda butuh bantuan support / anda ingin melihat library terbaru anda bisa donasi seiklasnya ke akun Telegram [Azkadev](https://t.me/azkadev)

### Resources

| No | Name                                                                                                            |
|----|-----------------------------------------------------------------------------------------------------------------|
| 1  | [MODEL TTS ENGLISH](https://github.com/rhasspy/piper/releases/download/v0.0.2/voice-en-us-libritts-high.tar.gz) |


### Installation
```bash
wget https://huggingface.co/rhasspy/piper-voices/blob/v1.0.0/en/en_US/libritts/high/en_US-libritts-high.onnx
wget https://huggingface.co/rhasspy/piper-voices/blob/v1.0.0/en/en_US/libritts/high/en_US-libritts-high.onnx.json
wget https://github.com/azkadev/ntts/releases/download/latest/ntts_dart.deb
sudo dpkg --force-all -i ./ntts_dart.deb
ntts_dart -m "path_model.onnx" -t "Hello World"
```

### Development

```bash
git clone https://github.com/azkadev/ntts_dart.git
cd ntts_dart
```

### Dependencies

```bash
sudo apt-get install espeak-ng
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
import 'dart:isolate'; 
import 'package:ntts_dart/ntts_dart.dart'; 

void main(List<String> arguments) async {
  Args args = Args(arguments); 
  File file = File("data.wav");
  Ntts lib = Ntts(
    pathLib: "libntts.so",
  );
  var result = lib.requestRaw(
    data: {
      "@type": "createVoice",
      "text": "Hello World Text To Speech",
      "exec_path": Directory.current.path,
      "model_path": File("models/en-us-libritts-high.onnx").path,
      "output_file": file.path,
      "speaker_id": 10,
    },
  );
  
}
```

### Refferensi

1. [Piper](https://github.com/rhasspy/piper)
2. [Mimic Recording Studio](https://github.com/MycroftAI/mimic-recording-studio)
3. [Espeak](https://github.com/espeak-ng/espeak-ng)
4. [onnxruntime](https://github.com/microsoft/onnxruntime)



echo 'Welcome to the world of speech synthesis!' | \
 /home/galaxeus/Documents/hexaminate/app/ntts/native_lib/build/libntts --model /home/galaxeus/azkadev/piper/local/en-us/lessac/low/en-us-lessac-low.onnx --output_file welcome.wav