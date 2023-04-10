import 'package:flutter/material.dart';
import 'package:webengage_flutter/webengage_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WebEngagePlugin _webEngagePlugin = new WebEngagePlugin();
  }

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..loadRequest(Uri.parse(
        "https://adityawebengage.github.io/WebEngage-WebBridge-Sample/"))
    ..addJavaScriptChannel("login",
        onMessageReceived: (JavaScriptMessage message) {
      print("flutter logging in with cuid : ${message.message}");
      WebEngagePlugin.userLogin(message.message);
    })
    ..addJavaScriptChannel("logout",
        onMessageReceived: (JavaScriptMessage message) {
      print("flutter logging out : ${message.message}");
      WebEngagePlugin.userLogout();
    })
    ..addJavaScriptChannel("__WEBENGAGE_MOBILE_BRIDGE__",
        onMessageReceived: (JavaScriptMessage message) {
      print("flutter message received from bridge : ${message.message}");
      WebEngagePlugin.userLogout();
    })
    ..addJavaScriptChannel("setAttribute",
        onMessageReceived: (JavaScriptMessage message) {
      print(message.message);

        })
  ..addJavaScriptChannel("track", onMessageReceived: (JavaScriptMessage message){
    print(message.message);

  })
  ..addJavaScriptChannel("screen", onMessageReceived: (JavaScriptMessage message){
    print(message.message);
  });
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
