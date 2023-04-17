# Neural Text To Speech

Neural Text To Speech Library untuk menghasilkan suara realistis seperti natural di bahasa dart, neural text to speech ini berjalan tanpa perlu koneksi internet dan hanya membutuhkan cpu saja

### Demo

[![](https://raw.githubusercontent.com/azkadev/ntts_dart/main/.github/youtube_ntts.jpg)](https://youtu.be/IfOJs7OUH8o)


https://user-images.githubusercontent.com/82513502/232475337-c02e24fd-52a7-4a4a-933c-b8f69aeedb5b.mp4

---


### Resources

| No | Name |
|----|------|
| 1  |      |


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
  var result = lib.request(
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
