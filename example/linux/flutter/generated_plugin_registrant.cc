//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <azure_speech_recognition_services/azure_speech_recognition_services_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) azure_speech_recognition_services_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "AzureSpeechRecognitionServicesPlugin");
  azure_speech_recognition_services_plugin_register_with_registrar(azure_speech_recognition_services_registrar);
}
