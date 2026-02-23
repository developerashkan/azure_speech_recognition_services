#ifndef FLUTTER_PLUGIN_AZURE_SPEECH_RECOGNITION_SERVICES_PLUGIN_H_
#define FLUTTER_PLUGIN_AZURE_SPEECH_RECOGNITION_SERVICES_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace azure_speech_recognition_services {

class AzureSpeechRecognitionServicesPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  AzureSpeechRecognitionServicesPlugin();

  virtual ~AzureSpeechRecognitionServicesPlugin();

  // Disallow copy and assign.
  AzureSpeechRecognitionServicesPlugin(const AzureSpeechRecognitionServicesPlugin&) = delete;
  AzureSpeechRecognitionServicesPlugin& operator=(const AzureSpeechRecognitionServicesPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace azure_speech_recognition_services

#endif  // FLUTTER_PLUGIN_AZURE_SPEECH_RECOGNITION_SERVICES_PLUGIN_H_
