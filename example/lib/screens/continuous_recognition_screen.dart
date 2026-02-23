import 'package:azure_speech_recognition_services/azure_speech_recognition_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ContinuousRecognitionScreen extends StatefulWidget {
  const ContinuousRecognitionScreen({super.key});

  @override
  State<ContinuousRecognitionScreen> createState() =>
      _ContinuousRecognitionScreenState();
}

class _ContinuousRecognitionScreenState
    extends State<ContinuousRecognitionScreen> {
  bool _isMicOn = false;
  String _intermediateResult = '';
  String _recognizedText = '';

  @override
  void initState() {
    super.initState();

    final AzureSpeechRecognitionServices azureSpeechRecognition =
        AzureSpeechRecognitionServices();
    AzureSpeechRecognitionServices.initialize(
        dotenv.get('AZURE_TOKEN'), dotenv.get('AZURE_REGION'),
        lang: 'en-US', timeout: '1500');
    azureSpeechRecognition.setFinalTranscription((text) {
      if (text.isEmpty) return;

      setState(() {
        _recognizedText += " $text";
        _intermediateResult = '';
      });
    });
    azureSpeechRecognition.onExceptionHandler(
        (exception) => debugPrint("Speech recognition exception: $exception"));
    azureSpeechRecognition.setRecognitionStartedHandler(
        () => debugPrint("Speech recognition has started."));
    azureSpeechRecognition.setRecognitionStoppedHandler(
        () => debugPrint("Speech recognition has stopped."));
    azureSpeechRecognition.setRecognitionResultHandler((text) {
      setState(() {
        _intermediateResult = text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Continuous Recognition'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                _isMicOn = !_isMicOn;
              });
              AzureSpeechRecognitionServices.continuousRecording();
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isMicOn ? Colors.green : Colors.red,
              ),
              child: Icon(
                _isMicOn ? Icons.mic : Icons.mic_off,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('Recognizing: $_intermediateResult'),
          SizedBox(height: 20),
          Expanded(
            child: TextField(
              readOnly: true,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Transcription',
              ),
              controller: TextEditingController(text: _recognizedText),
            ),
          ),
        ],
      ),
    );
  }
}
