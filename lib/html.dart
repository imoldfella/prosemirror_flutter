import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart';
import 'div.dart';
import 'dart:html' as html;

class HtmlController {
  EditorContent? content;
  String text;

  // receive changes from inside
  Function(List<EditorStep> ed)? store;

  // modify the editor from outside.
  Function(EditorStep step) update = badUpdate;

  HtmlController({String this.text = ""});
}

class HtmlField extends StatefulWidget {
  HtmlController? controller;

  HtmlField({this.controller});

  @override
  State<HtmlField> createState() => _HtmlFieldState();
}

class _HtmlFieldState extends State<HtmlField> {
  EditorDiv div = EditorDiv();
  late HtmlController controller;
  @override
  void initState() {
    controller = widget.controller ?? HtmlController();
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

class Html extends StatefulWidget {
  HtmlController? controller;
  String? text;
  bool contentEditable;

  Html({super.key, this.controller, this.text, this.contentEditable = false});

  @override
  State<Html> createState() => _HtmlState();
}

class _HtmlState extends State<Html> {
  late EditorDiv div;
  late HtmlController controller;

  @override
  void initState() {
    controller = widget.controller ?? HtmlController();
    if (widget.text != null) {
      controller.text = widget.text!;
    }
    div = EditorDiv(text: controller.text);
    super.initState();
    //alertMessage(div.id);
    print(
        "${div.id}, ${div.div.children[0].getAttribute('id')}, ${div.div.outerHtml},${html.document.getElementById(div.id)}");

    //Html(div.div);
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

// @JS('window.Html')
// external void Html(dynamic s);
//https://dev.to/graphicbeacon/how-to-use-javascript-libraries-in-your-dart-applications--4mc6
// @JS('window.alertMessage')
// external void alertMessage(String s);
