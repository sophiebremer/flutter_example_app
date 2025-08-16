import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
    var scrollController = ScrollController();
    var webviewController = WebViewController.fromPlatform(
      WebWebViewController(WebWebViewControllerCreationParams()),
    );

    webviewController.loadHtmlString('''<!DOCTYPE><html><head>
      <meta charset="UTF-8" />
      <title>WebWebView</title>
    </head><body>
      <h1>WebWebView</h1>
    </body></html>''');

    return MaterialApp(
      title: 'Flutter Example App',
      theme: ThemeData(colorScheme: colorScheme),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.primaryContainer,
          title: const Text('Flutter Example App'),
        ),
        body: SafeArea(
          child: Scrollbar(
            controller: scrollController,
            child: ListView(
              children: [
                SizedBox(
                  height: 480,
                  child: WebViewWidget(controller: webviewController),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
