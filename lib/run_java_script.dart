import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

import 'main.dart' show colorScheme;

class RunJavaScript extends StatefulWidget {
  const RunJavaScript({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RunJavaScriptState();
  }
}

class _RunJavaScriptState extends State<RunJavaScript> {
  int _count = 80;
  late final ScrollController _scrollController;
  late final WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: colorScheme.primaryContainer,
        title: const Text('runJavaScript Example'),
      ),
      body: SafeArea(
        child: Scrollbar(
          controller: _scrollController,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(20, 20, 20, 20),
                child: Column(
                  children: [
                    Text('Number of particles'),
                    Wrap(
                      runSpacing: 5,
                      spacing: 5,
                      children: List<Widget>.generate(9, (int index) {
                        int count = (index + 1) * 10;
                        return ChoiceChip(
                          label: Text('$count'),
                          selected: _count == count,
                          onSelected: (bool selected) {
                            setState(() {
                              _count = count;
                            });
                            _webViewController.runJavaScript('''
                          updateParticleCount($count);
                        ''');
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(20, 0, 20, 20),
                child: SizedBox(
                  height: 480,
                  child: WebViewWidget(controller: _webViewController),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    final particlesPath = 'particles.html';

    super.initState();

    _scrollController = ScrollController();
    _webViewController = WebViewController.fromPlatform(
      WebWebViewController(WebWebViewControllerCreationParams()),
    );

    http
        .read(Uri(path: particlesPath))
        .then(
          (response) => _webViewController.loadHtmlString(
            response,
            baseUrl: particlesPath,
          ),
        );
  }
}
