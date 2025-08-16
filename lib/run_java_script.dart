import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

import 'main.dart' show colorScheme;

class RunJavaScript extends StatelessWidget {
  const RunJavaScript({super.key});

  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();
    var webViewController = WebViewController.fromPlatform(
      WebWebViewController(WebWebViewControllerCreationParams()),
    );

    webViewController.loadHtmlString('''<!DOCTYPE><html><head>
      <meta charset="UTF-8" />
      <title>WebWebView</title>
    </head><body>
      <h1>WebWebView</h1>
    </body></html>''');
    webViewController.runJavaScript('''
      document.body.append('JavaScript executed');
    ''');

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: colorScheme.primaryContainer,
        title: const Text('runJavaScript Example'),
      ),
      body: SafeArea(
        child: Scrollbar(
          controller: scrollController,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 0,
                  horizontal: 20,
                ),
                child: SizedBox(
                  height: 480,
                  child: WebViewWidget(controller: webViewController),
                ),
              ),
              TextButton(
                onPressed: () => webViewController.runJavaScript('''
                    alert('Namespace does' + (
                      window.FlutterExampleApp ? '' : ' not'
                    ) + ' exist.');
                  '''),
                child: const Text('Check Namespace'),
              ),
              TextButton(
                onPressed: () => webViewController.runJavaScript('''
                    window.FlutterExampleApp = {};
                  '''),
                child: const Text('Inject Namespace'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
