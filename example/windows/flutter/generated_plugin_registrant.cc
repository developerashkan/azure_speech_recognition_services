//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <azure_speech_recognition_services/azure_speech_recognition_services_plugin_c_api.h>
#include <permission_handler_windows/permission_handler_windows_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AzureSpeechRecognitionServicesPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AzureSpeechRecognitionServicesPluginCApi"));
  PermissionHandlerWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PermissionHandlerWindowsPlugin"));
}
