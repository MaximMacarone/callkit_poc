#include <callkit_poc/callkit_poc_plugin.h>

namespace Channels {
constexpr auto Methods = "callkit_poc";
} // namespace Channels

namespace Methods {
constexpr auto PlatformVersion = "getPlatformVersion";
} // namespace Methods

void CallkitPocPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrar *registrar) {
  // Create MethodChannel with StandardMethodCodec
  auto methodChannel = std::make_unique<MethodChannel>(
      registrar->messenger(), Channels::Methods,
      &flutter::StandardMethodCodec::GetInstance());

  // Create plugin
  std::unique_ptr<CallkitPocPlugin> plugin(
      new CallkitPocPlugin(std::move(methodChannel)));

  // Register plugin
  registrar->AddPlugin(std::move(plugin));
}

CallkitPocPlugin::CallkitPocPlugin(
    std::unique_ptr<MethodChannel> methodChannel)
    : m_methodChannel(std::move(methodChannel)) {
  // Create MethodHandler
  RegisterMethodHandler();
}

void CallkitPocPlugin::RegisterMethodHandler() {
  m_methodChannel->SetMethodCallHandler(
      [this](const MethodCall &call, std::unique_ptr<MethodResult> result) {
        if (call.method_name().compare(Methods::PlatformVersion) == 0) {
          result->Success(onGetPlatformVersion());
        } else {
          result->Success();
        }
      });
}

EncodableValue
CallkitPocPlugin::onGetPlatformVersion() {
  return "Aurora OS.";
}
