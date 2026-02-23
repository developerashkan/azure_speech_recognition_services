# azure_speech_recognition_services

A Flutter plugin for Microsoft Azure Speech-to-Text that supports:

- single-shot recognition (listen once, stop on silence),
- continuous recognition (toggle start/stop stream), and
- optional pronunciation assessment callbacks.

## What this plugin does

`azure_speech_recognition_services` wraps native Azure Speech SDK behavior behind a Flutter `MethodChannel` API so you can:

- initialize Azure credentials once,
- register Dart callbacks for recognition events,
- start simple or continuous speech recognition, and
- receive partial/final transcription results in real time.

Core Dart API lives in `AzureSpeechRecognitionServices`.

## Installation

Add the package to your Flutter app:

```yaml
dependencies:
  azure_speech_recognition_services: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Azure prerequisites

Before using the plugin, create an Azure Speech resource and get:

- `subscriptionKey`
- `region` (for example: `westeurope`, `eastus`, ...)

You pass those values to `AzureSpeechRecognitionServices.initialize(...)`.

## Platform notes

This plugin uses native speech recognition integrations on mobile platforms.

- You should request microphone permission in your application.
- Use a valid Azure Speech subscription key + region.
- Language defaults to `en-EN`; pass `lang` explicitly if needed (for example `en-US`, `it-IT`, `de-DE`).

## Complete usage example

The following widget shows a full, practical setup for:

- initialization,
- callback wiring,
- single-shot recognition,
- continuous recognition toggle,
- cleanup.

```dart
import 'package:azure_speech_recognition_services/azure_speech_recognition_services.dart';
import 'package:flutter/material.dart';

class AzureSpeechDemo extends StatefulWidget {
  const AzureSpeechDemo({super.key});

  @override
  State<AzureSpeechDemo> createState() => _AzureSpeechDemoState();
}

class _AzureSpeechDemoState extends State<AzureSpeechDemo> {
  final AzureSpeechRecognitionServices _speech =
      AzureSpeechRecognitionServices();

  // Replace with your real values (or load from secure/env config).
  final String _subscriptionKey = 'YOUR_AZURE_SPEECH_KEY';
  final String _region = 'YOUR_AZURE_REGION';

  String _partialText = '';
  String _finalText = '';
  String _assessmentJson = '';
  String _status = 'Idle';
  bool _isContinuous = false;

  @override
  void initState() {
    super.initState();

    AzureSpeechRecognitionServices.initialize(
      _subscriptionKey,
      _region,
      lang: 'en-US',
      timeout: '2000', // valid range: 100..5000
    );

    _speech.setRecognitionStartedHandler(() {
      setState(() => _status = 'Recognition started');
    });

    _speech.setRecognitionResultHandler((text) {
      setState(() => _partialText = text);
    });

    _speech.setFinalTranscription((text) {
      setState(() {
        _finalText = text;
        _status = 'Final transcription received';
      });
    });

    _speech.setAssessmentResult((json) {
      setState(() => _assessmentJson = json);
    });

    _speech.setStartHandler(() {
      setState(() {
        _isContinuous = true;
        _status = 'Continuous recognition ON';
      });
    });

    _speech.setRecognitionStoppedHandler(() {
      setState(() {
        _isContinuous = false;
        _status = 'Continuous recognition OFF';
      });
    });

    _speech.onExceptionHandler((message) {
      setState(() => _status = 'Error: $message');
    });
  }

  Future<void> _startSingleShot() async {
    AzureSpeechRecognitionServices.simpleVoiceRecognition();
  }

  Future<void> _toggleContinuous() async {
    AzureSpeechRecognitionServices.continuousRecording();
  }

  Future<void> _singleShotWithAssessment() async {
    AzureSpeechRecognitionServices.simpleVoiceRecognitionWithAssessment(
      referenceText: 'The quick brown fox jumps over the lazy dog.',
      granularity: 'Phoneme',
      phonemeAlphabet: 'IPA',
      enableMiscue: true,
      nBestPhonemeCount: 5,
    );
  }

  @override
  void dispose() {
    // Defensive cleanup if continuous recognition is still active.
    AzureSpeechRecognitionServices.stopContinuousRecognition();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Azure Speech Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: $_status'),
            const SizedBox(height: 12),
            Text('Partial: $_partialText'),
            const SizedBox(height: 8),
            Text('Final: $_finalText'),
            const SizedBox(height: 8),
            Text('Assessment JSON: $_assessmentJson'),
            const Spacer(),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: _startSingleShot,
                  child: const Text('Single-shot recognize'),
                ),
                ElevatedButton(
                  onPressed: _singleShotWithAssessment,
                  child: const Text('Single-shot + assessment'),
                ),
                ElevatedButton(
                  onPressed: _toggleContinuous,
                  child: Text(
                    _isContinuous
                        ? 'Stop continuous'
                        : 'Start continuous',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## API quick reference

### 1) Initialization

```dart
AzureSpeechRecognitionServices.initialize(
  subscriptionKey,
  region,
  lang: 'en-US',
  timeout: '2000',
);
```

- `timeout` must be an integer string in range `100..5000`.

### 2) Event handlers

Register handlers on the singleton instance:

- `setRecognitionStartedHandler`
- `setRecognitionResultHandler` (partial text)
- `setFinalTranscription` (final text)
- `setAssessmentResult` (assessment JSON/text)
- `setStartHandler` (continuous mode started)
- `setRecognitionStoppedHandler` (continuous mode stopped)
- `onExceptionHandler`

### 3) Recognition methods

- `simpleVoiceRecognition()`
- `simpleVoiceRecognitionWithAssessment(...)`
- `continuousRecording()` (toggle)
- `continuousRecordingWithAssessment(...)` (toggle)
- `isContinuousRecognitionOn()`
- `stopContinuousRecognition()`

## Recommended integration pattern

1. Create one `AzureSpeechRecognitionServices()` instance in your state object.
2. Call `initialize(...)` once (for current credentials/language).
3. Register all callbacks in `initState`.
4. Trigger recognition from explicit UI actions (buttons/gestures).
5. Stop continuous recognition in `dispose` for safe cleanup.

## Formatting

On Windows, `dart format .` can fail when generated Android build artifacts
contain invalid or missing transformed directories.

Use the repo formatter scripts instead:

```bash
./tool/format.sh
```

```powershell
./tool/format.ps1
```

These scripts format only tracked Dart source files, so generated directories
like `build/` and `example/build/` are automatically ignored.
