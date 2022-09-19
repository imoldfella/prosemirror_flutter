import 'package:flutter/cupertino.dart';
import 'dart:typed_data';

import 'dart:html' as html;
import 'dart:ui' as ui;

import 'div.dart';
import 'package:js/js.dart';

// since this is designed for small pieces of text we

// EditorContent should indicate the editor that should format and attach handlers to
// the input. Maybe like a channel to one item in the list.
class ListController extends ChangeNotifier {
  int length = 0; // virtual

  Function(EditorContent)? store;
  Future<EditorContent> Function(int i)? load;

  ListController(
      {int itemCount = 0,
      Function(int index, EditorContent e)? store,
      Future<EditorContent> Function(int index)? load});
}

// this is the web version.
class EditorListView extends StatefulWidget {
  late ListController controller;
  EditorListView({ListController? controller, super.key}) {
    this.controller = controller ?? ListController();
  }

  @override
  State<EditorListView> createState() => _EditorListViewState();
}

class _EditorListViewState extends State<EditorListView> {
  EditorDiv div = EditorDiv(text: "hello, world");

  @override
  Widget build(BuildContext context) {
    return div.widget;
  }
}

// we want this to be a virtual list
// there has to be a 1 pixel shim
// then we need to position each html in the virtual canvas.
var id = 0;
String uniqueId() => "DG-${id++}";

// we might need to proxy this to the web browser so collect in a state.
class EditorDivListState {
  int start = 0;
  List<String> div = [];
  List<double> offset = [];

  List<double> height = [];
  double tombstoneHeight = 32;
  String tombstone = "<p>tombstone<p>";
}

class EditorDivList {
  late html.DivElement div;
  late String viewType;

  EditorDivListState state = EditorDivListState();
  void setState(EditorDivListState x) {
    state = x;
  }

  EditorDivList(
      {
      // the scroll has changed.
      void Function()? onScroll,
      void Function()? onSize,
      void Function()? onLongPress}) {
    // we need to attach a listener to the scroll.

    var text = List<String>.generate(
            100,
            (e) =>
                "<div>well in this case the test is pretty easy, put a bunch of random numbers into a List, sort them, compress them, decompress them, and see if you have the same List</div>")
        .join("");

    var b = """<style scoped>
  div:focus {
    outline: none
  }
</style><div spellcheck="true" autocapitalize="on" style='user-select: text; color: black; position: fixed; padding-top: 64px' contenteditable  id='pm'  >$text</div>""";

    div = html.DivElement()
      ..style.width = '100%'
      ..style.height = '100%'
      ..setInnerHtml(b, treeSanitizer: html.NodeTreeSanitizer.trusted);
    viewType = uniqueId();

    // we should try to set up in javascript so we can

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewType, (_) {
      return div;
    });
  }
}

// void alert() {
//   js.context
//       .callMethod('alertMessage', ['Flutter is calling upon JavaScript!']);
//   js.context.callMethod('logger', ["_someFlutterState"]);
//   var state = js.JsObject.fromBrowserObject(js.context['state']);
//   print(state['hello']);
// }
