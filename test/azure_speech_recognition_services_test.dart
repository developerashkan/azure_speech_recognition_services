import 'package:flutter_test/flutter_test.dart';
import 'package:azure_speech_recognition_services/azure_speech_recognition_services.dart';
import 'package:azure_speech_recognition_services/azure_speech_recognition_services_platform_interface.dart';
import 'package:azure_speech_recognition_services/azure_speech_recognition_services_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAzureSpeechRecognitionServicesPlatform
    with MockPlatformInterfaceMixin
    implements AzureSpeechRecognitionServicesPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AzureSpeechRecognitionServicesPlatform initialPlatform = AzureSpeechRecognitionServicesPlatform.instance;

  test('$MethodChannelAzureSpeechRecognitionServices is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAzureSpeechRecognitionServices>());
  });

  test('getPlatformVersion', () async {
    MockAzureSpeechRecognitionServicesPlatform fakePlatform = MockAzureSpeechRecognitionServicesPlatform();
    AzureSpeechRecognitionServicesPlatform.instance = fakePlatform;

  });
}
