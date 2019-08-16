import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_native_string_res/flutter_native_string_res.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _resourceContent = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String resourceContent;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      var res = NativeStringResource(
        androidName: 'hello',
        iOSName: 'hello',
        iOSPlistName: 'Test_list'
      );
      resourceContent = await res.value;
    } on PlatformException catch(e,s) {
      print('Exception $e:\n$s');
      resourceContent = 'Failed to get resource string value.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _resourceContent = resourceContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Resource value: $_resourceContent\n'),
        ),
      ),
    );
  }
}
