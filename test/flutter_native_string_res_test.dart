import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_native_string_res/flutter_native_string_res.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_native_string_res');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'Hello world!';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await NativeStringResource(androidName: 'hello', iOSName: 'hello', iOSPlistName: 'hello').value, 'Hello world!');
  });
}
