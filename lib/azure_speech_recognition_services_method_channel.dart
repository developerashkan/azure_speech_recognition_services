import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'azure_speech_recognition_services_platform_interface.dart';

/// An implementation of [AzureSpeechRecognitionServicesPlatform] that uses method channels.
class MethodChannelAzureSpeechRecognitionServices extends AzureSpeechRecognitionServicesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('azure_speech_recognition_services');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
