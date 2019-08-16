package com.flutter.flutter_native_string_res;

import android.content.Context;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterNativeStringResPlugin */
public class FlutterNativeStringResPlugin implements MethodCallHandler {
  static Context context;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_native_string_res");
    channel.setMethodCallHandler(new FlutterNativeStringResPlugin());
    context = registrar.context();
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getValue")) {
      final String name = call.argument("name");
      final int resId = context.getResources().getIdentifier(name, "string", context.getPackageName());
      if(resId == 0)
        result.error("resource_missing", "The requested resource '" + name + "' does not exist", null);
      else
        result.success(context.getString(resId));
    } else {
      result.notImplemented();
    }
  }
}
