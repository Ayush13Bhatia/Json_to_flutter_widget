import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/basic/dynamic_widget_json_exportor.dart';
import 'package:flutter/material.dart';

class JsonPreview extends StatefulWidget {
  final String? jsonPreview;
  const JsonPreview({Key? key, this.jsonPreview}) : super(key: key);

  @override
  State<JsonPreview> createState() => _JsonPreviewState();
}

class _JsonPreviewState extends State<JsonPreview> {
  Future<Widget?> _buildWidget(BuildContext context) async {
    return DynamicWidgetBuilder.build('${widget.jsonPreview}', context, DefaultClickListener());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generated JSON Widget"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Widget?>(
              future: _buildWidget(context),
              builder: (BuildContext context, AsyncSnapshot<Widget?> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return DynamicWidgetJsonExportor(
                  child: snapshot.data,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DefaultClickListener implements ClickListener {
  @override
  void onClicked(String? event) {
    print('object52');
    print("Receive click event: " + (event == null ? "" : event));
  }
}
