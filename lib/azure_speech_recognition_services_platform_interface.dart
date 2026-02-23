import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'azure_speech_recognition_services_method_channel.dart';

abstract class AzureSpeechRecognitionServicesPlatform extends PlatformInterface {
  /// Constructs a AzureSpeechRecognitionServicesPlatform.
  AzureSpeechRecognitionServicesPlatform() : super(token: _token);

  static final Object _token = Object();

  static AzureSpeechRecognitionServicesPlatform _instance = MethodChannelAzureSpeechRecognitionServices();

  /// The default instance of [AzureSpeechRecognitionServicesPlatform] to use.
  ///
  /// Defaults to [MethodChannelAzureSpeechRecognitionServices].
  static AzureSpeechRecognitionServicesPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AzureSpeechRecognitionServicesPlatform] when
  /// they register themselves.
  static set instance(AzureSpeechRecognitionServicesPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
