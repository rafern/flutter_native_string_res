# flutter_native_string_res

Flutter plugin for getting native string resources

## Usage
Check the example folder for code examples.
To get a string resource, create a `NativeStringResource` instance. The constructor is the following:

- String androidName: Name of string resource for Android
- String iOSName: Name of string resource for iOS
- String iOSPlistName: Name of property list file for iOS __(omit the .plist extension)__

All of these arguments can be omitted if, e.g., you are only fetching values for one platform.

To get the actual string from the resource, call the `value` getter of the created instance. Example:
```dart
var helloRes = NativeStringResource(
  androidName: 'hello',
  iOSName: 'hello',
  iOSPlistName: 'Test_plist'
);

print(await helloRes.value);
```
This will print `Hello world!` in the example project.

Setting values is __not__ supported. Values other than strings are __not__ supported

## Maintenance
This was a quick and dirty plugin I wrote so don't expect updates. Feel free to fork as I won't license this
