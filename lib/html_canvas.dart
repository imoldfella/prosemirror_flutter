import 'package:flutter/cupertino.dart';

// 3 layers:
// 1. a size layer. this is a guess at the current size based on number of items + subset that are visible/cached. This is positioned relative to the view port to enable scrolling. Transformed single pixel space.
// 2. A cache layer. this is positioned absolute to the size layer. we only need to move these when a visible item is deleted. the
// 3. viewport layer to clip.

class HtmlCanvas {
  Function(HcMessage m)? onMessage;

  List<HtmlComponent> component = [];
}

class HcMessage {
  int object = 0;
  String method = "d";
  Map<String, dynamic> params = {};
}

// transactions are encodable as messages
// the messages have to be general, like cbor/json because we can't know
// what plugins will exist and what they will allow at compile time.
class HcTx {
  HtmlCanvas canvas;
  HcTx(this.canvas);
  send(int object, String method, Map<String, dynamic> params) {}
  int create(String componentType) {
    // deletion involves sending delete to the object and the object send back complete.
    return 0;
  }

  commit() {}
}

// remove(int index) {}
// add(int index, HtmlComponent) {}
// animateTo(index, Offset x) {}

abstract class HtmlComponent {
  String encodeJson();
  // menu options at least, maybe some decoration flags?

  // this should be right click on deskstop.
  focusMenu() {}
}

// our div needs a channel that is a call for web and a post for mobile
// we want to encode the HcTx to update the on-screen components.
//

// needs a grid observer that

