#include "include/azure_speech_recognition_services/azure_speech_recognition_services_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "azure_speech_recognition_services_plugin.h"

void AzureSpeechRecognitionServicesPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  azure_speech_recognition_services::AzureSpeechRecognitionServicesPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
