import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prosemirror_flutter/prosemirror_flutter.dart' as pm;

void main() {
  runApp(const MyApp());
}

var text1 =
    """<p>Parses the HTML fragment and sets it as the contents of this element. This ensures that the generated content follows the sanitization rules specified by the validator or treeSanitizer</p>.

<p>If the default validation behavior is too restrictive then a new NodeValidator should be created, either extending or wrapping a default validator and overriding the validation APIs.</p>""";

var text = List<String>.generate(20, (e) => text1).join();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prosemirror in Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Prosemirror in Flutter Demo'),
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
  pm.ProsemirrorController controller = pm.ProsemirrorController(text: text);

  pm.ListController listController = pm.ListController(
    itemCount: 10,
    load: (int index) async => pm.HtmlContent(text: "<p>Item $index</p>"),
  );
  pm.ProsemirrorController inputController =
      pm.ProsemirrorController(text: "hello, world");

  int editor = 0;

  @override
  Widget build(BuildContext context) {
    Widget edit() {
      switch (editor) {
        case 0: // full screen prosemirror editor
          return pm.Prosemirror(
            controller: controller,
          );
        case 1:
          return Column(
            children: [
              Expanded(child: pm.EditorListView(controller: listController)),
              SizedBox(
                  height: 64,
                  child: Container(
                      color: CupertinoColors.darkBackgroundGray,
                      child: Row(children: [
                        CupertinoButton(
                            onPressed: () {}, child: Icon(CupertinoIcons.add)),
                        Expanded(
                            child: pm.ProsemirrorField(
                                controller: inputController)),
                        CupertinoButton(
                            onPressed: () {},
                            child: Icon(CupertinoIcons.arrow_up_circle_fill))
                      ])))
            ],
          );
        case 2:
          // create a basic html view no editor.
          return pm.Html(
            text: text,
          );
        default:
          // som basic flutter, no html
          return Column(children: [
            Expanded(
                child: ListView(children: [
              ...List<Widget>.generate(100, (e) => Text("$e"))
            ])),
            SizedBox(
                height: 64,
                child: Row(children: [
                  CupertinoButton(
                      onPressed: () {}, child: Icon(CupertinoIcons.add)),
                  Expanded(
                    child: CupertinoSearchTextField(),
                  ),
                  CupertinoButton(
                      onPressed: () {}, child: Icon(CupertinoIcons.arrow_up))
                ]))
          ]);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            PopupMenuButton<String>(
              onSelected: (String s) {
                alert(context, s);
              },
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: edit());
  }
}

Future<void> alert(BuildContext context, String s) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(s),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
