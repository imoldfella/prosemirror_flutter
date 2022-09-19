import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:prosemirror_flutter/editor_list.dart';

// model a list of 1+ divs.

abstract class EditorContent {
  writeHtml(StringBuffer w);
}

class HtmlMessage {}

class HtmlContent extends EditorContent {
  String text;
  HtmlContent({required this.text});

  @override
  writeHtml(StringBuffer w) {
    w.write(text);
  }
}

// abstract class WebInteface {
//   void send(Map<String, String> message);
// }

class EditorStep {
  String key;
  Size? size;
  EditorStep(this.key);
}

class EditorChannel {
  EditorContent? content;

  // receive changes from inside
  Function(List<EditorStep> ed)? store;

  // modify the editor from outside.
  Function(EditorStep step) update = badUpdate;
}

void badUpdate(EditorStep step) {
  throw "not ready";
}

const styleScope = """""";

class EditorDiv {
  late html.DivElement div;
  late String viewType;
  static int counter = 0;
  Function(HtmlMessage)? onMessage;

  dispose() {
    div.remove();
  }

  String get id => viewType;

  EditorDiv({String text = "", contentEditable = true, this.onMessage}) {
    final id = uniqueId();
    var b = """<style scoped>
  div:focus {
    outline: none
    }
  }
</style><div 
  spellcheck="true" 
  autocapitalize="on" 
  style='user-select: text; color: blue' ${contentEditable ? "contenteditable" : ""}  id='$id'  >
  <div>$text</div></div>""";

    div = html.DivElement()
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.overflow = 'scroll'
      ..setInnerHtml(b, treeSanitizer: html.NodeTreeSanitizer.trusted)
      ..onWheel.listen((event) => event.stopPropagation())
      ..onMouseWheel.listen((event) => event.stopPropagation())
      ..onScroll.listen((event) {
        final target = event.target as html.DivElement;
      });
    viewType = id;

    // we should try to set up in javascript so we can

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewType, (_) {
      return div;
    });
  }

  Widget get widget => HtmlElementView(viewType: viewType);
}
