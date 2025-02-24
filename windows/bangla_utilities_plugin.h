#ifndef FLUTTER_PLUGIN_BANGLA_UTILITIES_PLUGIN_H_
#define FLUTTER_PLUGIN_BANGLA_UTILITIES_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace bangla_utilities {

class BanglaUtilitiesPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  BanglaUtilitiesPlugin();

  virtual ~BanglaUtilitiesPlugin();

  // Disallow copy and assign.
  BanglaUtilitiesPlugin(const BanglaUtilitiesPlugin&) = delete;
  BanglaUtilitiesPlugin& operator=(const BanglaUtilitiesPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace bangla_utilities

#endif  // FLUTTER_PLUGIN_BANGLA_UTILITIES_PLUGIN_H_
