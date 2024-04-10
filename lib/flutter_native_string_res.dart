import 'dart:io';

import 'package:flutter/services.dart';

class NativeStringResource {
  static const MethodChannel _channel =
      const MethodChannel('flutter_native_string_res');
      
  final String androidName;
  final String iOSName;
  final String iOSPlistName;

  NativeStringResource({
    required this.androidName,
    required this.iOSName,
    required this.iOSPlistName,
  });

  Future<String> get value async {
    String valName;
    String plistName = '';

    switch (Platform.operatingSystem) {
      case 'android':
        if (androidName.isEmpty) {
          throw new PlatformException(
              code: 'no_android_value_name',
              message:
                  'There is no provided value name for Android. androidName is null');
        }

        valName = androidName;
        break;
      case 'ios':
        if (iOSName.isEmpty) {
          throw new PlatformException(
              code: 'no_ios_value_name',
              message:
                  'There is no provided value name for iOS. iOSName is null');
        }

        if (iOSPlistName.isEmpty) {
          throw new PlatformException(
              code: 'no_ios_plist_name',
              message:
                  'There is no provided plist resource name for iOS. iOSPlistName is null');
        }

        valName = iOSName;
        plistName = iOSPlistName;
        break;
      default:
        throw new PlatformException(
            code: 'unsupported_platform',
            message:
                'The platform ${Platform.operatingSystem} is not supported');
    }

    Map<String, dynamic> arguments = {'name': valName, 'plist': plistName};

    return await _channel.invokeMethod('getValue', arguments);
  }
}
