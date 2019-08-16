#import "FlutterNativeStringResPlugin.h"

@implementation FlutterNativeStringResPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_native_string_res"
            binaryMessenger:[registrar messenger]];
  FlutterNativeStringResPlugin* instance = [[FlutterNativeStringResPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getValue" isEqualToString:call.method]) {
  // TODO finish me. use dictionary paths (not keys!)
    NSString *name = call.arguments[@"name"];
    NSString *plist = call.arguments[@"plist"];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource: plist ofType: @"plist"];
    NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    result([plistDict]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
