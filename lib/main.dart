import 'package:dynamic_widget/dynamic_widget/basic/dynamic_widget_json_exportor.dart';
import 'package:flutter/material.dart';

import 'json_preview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo JSON To Widget'),
      // home: Scaffold(body: JsonUI()),
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
  String? exportJsonString = '';
  String elevatedButtonJson = '';
  GlobalKey jsonkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                const Text(
                  'Generate the JSON widget:  ',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  key: Key("/someroute/someother"),
                  onPressed: () {
                    var exportor = jsonkey.currentWidget as DynamicWidgetJsonExportor;
                    exportJsonString = exportor.exportJsonString();
                    exportJsonString = exportJsonString!.replaceAll("[<'", "").replaceAll("'>]", "");
                    elevatedButtonJson = exportJsonString!.toString();
                    print(elevatedButtonJson);
                    setState(() {});
                  },
                  child: const Text("Generate JSON"),
                ),
                DynamicWidgetJsonExportor(
                  key: jsonkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: () {}, child: Text("First")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: () {}, child: Text("Second")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: () {}, child: Text("Third")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: () {}, child: Text("Fourth")),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(
                '$exportJsonString',
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: elevatedButtonJson.isNotEmpty
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JsonPreview(
                      jsonPreview: elevatedButtonJson,
                    ),
                  ),
                );
              }
            : null,
        tooltip: 'JSON generated Widget',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
