import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart';
import 'div.dart';
import 'dart:html' as html;

class ProsemirrorController {
  EditorContent? content;
  String text;

  // receive changes from inside
  Function(List<EditorStep> ed)? store;

  // modify the editor from outside.
  Function(EditorStep step) update = badUpdate;

  ProsemirrorController({String this.text = ""});
}

class ProsemirrorField extends StatefulWidget {
  ProsemirrorController? controller;

  ProsemirrorField({this.controller});

  @override
  State<ProsemirrorField> createState() => _ProsemirrorFieldState();
}

class _ProsemirrorFieldState extends State<ProsemirrorField> {
  EditorDiv div = EditorDiv();
  late ProsemirrorController controller;
  @override
  void initState() {
    controller = widget.controller ?? ProsemirrorController();
    div = EditorDiv(text: controller.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //     height: kBottomNavigationBarHeight,
    //     child: SelectableText(controller.text));

    return SizedBox(height: kBottomNavigationBarHeight, child: div.widget);
  }
}

class Prosemirror extends StatefulWidget {
  ProsemirrorController? controller;

  Prosemirror({super.key, this.controller});

  @override
  State<Prosemirror> createState() => _ProsemirrorState();
}

class _ProsemirrorState extends State<Prosemirror> {
  late EditorDiv div;
  late ProsemirrorController controller;

  @override
  void initState() {
    controller = widget.controller ?? ProsemirrorController();
    div = EditorDiv(text: controller.text);
    super.initState();
    //alertMessage(div.id);
    print(
        "${div.id}, ${div.div.children[0].getAttribute('id')}, ${div.div.outerHtml},${html.document.getElementById(div.id)}");

    prosemirror(div.div);
  }

  @override
  void dispose() {
    div.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return div.widget;
  }
}

@JS('window.prosemirror')
external void prosemirror(dynamic s);
//https://dev.to/graphicbeacon/how-to-use-javascript-libraries-in-your-dart-applications--4mc6
// @JS('window.alertMessage')
// external void alertMessage(String s);
