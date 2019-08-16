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
    // Get method call arguments
    NSString *name = call.arguments[@"name"];
    NSString *plist = call.arguments[@"plist"];

    // Find property list file
    NSString *plistPath = [[NSBundle mainBundle] pathForResource: plist ofType: @"plist"];
    if(plistPath == nil) {
        result([FlutterError errorWithCode:@"missing_plist"
                                   message:@"Property list does not exist"
                                   details:nil]);
    }

    // Get plist content
    NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile: plistPath];
    if(plistDict == nil) {
        result([FlutterError errorWithCode:@"invalid_plist"
                                   message:@"An error occurred while parsing the property list"
                                   details:nil]);
    }

    // Get value
    NSObject *value = [plistDict valueForKeyPath: name];
    if(value == nil) {
        result([FlutterError errorWithCode:@"missing_key"
                                   message:@"Key does not exist"
                                   details:nil]);
    }
    else {
        if([value isKindOfClass:[NSString class]]) {
            result(value);
        }
        else {
            result([FlutterError errorWithCode:@"not_a_string"
                                       message:@"Value is not a string"
                                       details:nil]);
        }
    }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
