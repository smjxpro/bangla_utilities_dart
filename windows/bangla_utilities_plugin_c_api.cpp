#include "include/bangla_utilities/bangla_utilities_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "bangla_utilities_plugin.h"

void BanglaUtilitiesPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  bangla_utilities::BanglaUtilitiesPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
