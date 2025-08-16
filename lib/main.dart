import 'package:flutter/material.dart';
import 'package:flutter_example_app/run_java_script.dart' show RunJavaScript;

void main() {
  runApp(const MyApp());
}

var colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example App',
      theme: ThemeData(colorScheme: colorScheme),
      home: Main(),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        title: const Text('Flutter Example App'),
      ),
      body: SafeArea(
        child: Scrollbar(
          controller: scrollController,
          child: ListView(
            children: [
              ListTile(title: Text('Examples:')),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RunJavaScript(),
                  ),
                ),
                child: Text('runJavaScript'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
