import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

// a grid observer is a window on a large grid.
// we can set the width of each column.

// row major order
class Matrix2<T> {
  int width = 0;
  List<T> data = [];
  Matrix2(this.width, this.data);

  static Matrix2<T> generate<T>(int x, int y, T Function(int x, int y) gen) {
    return Matrix2(
        x, List<T>.generate(x * y, (e) => gen((e / y).floor(), e % y)));
  }
}

// we can rotate this so width becomes height.
class Replace<T> {
  int start = 0, begin = 0;
  List<T> insert = [];
}

class Bytes {
  Uint8List data;
  Bytes(this.data);

  @override
  int get hashCode => 0;
  @override
  bool operator ==(Object other) =>
      other is Bytes && listEquals(data, other.data);

  Bytes operator +(Bytes b) => Bytes(Uint8List.fromList([...data, ...b.data]));
}

class GridTransaction<T> {
  List<Replace<Bytes>> row = [];
  List<Replace<Bytes>> col = [];
  List<T> values = [];
}

class GridObserver<T> extends ChangeNotifier {
  int begin = 0;
  int end = 0;

  observeRows(int begin, int end) {}
  // most recent delta; this goes away when notify completes.
  GridTransaction<T> tx = GridTransaction();
}

class Measure {
  List<int> id = [];
  List<double> width = [];
}

class MeasureResponse {
  List<double> height = [];
}

class CanvasGrid extends StatefulWidget {
  @override
  State<CanvasGrid> createState() => _CanvasGridState();
}

// we will want our row height cache to be very large, although not necessarily 100%
// we can probably hold onto their formatted state for a large cache.

// this is a lens, not the entire spreadsheet.
// we don't need to format it for every every view, we could format to invisible canvas. not sure what that does for multi monitor. a shame to throw it away? should we store heights? what unit would we store heights in? maybe points? if we let people have different widths, then they will have different heights as well.

class _CanvasGridState extends State<CanvasGrid> {
  GridObserver grid = GridObserver();
  final cell = Matrix2<Cell>(0, []);

  _update() {
    // triggered when the grid observer changes.
    // encode the transaction and send it to javascript.
    // tell javascript what s
    final tx = grid.tx;
  }

  _updateScroll() {
    // webview has moved the view port. we don't necessarily have to do anything
    // if the viewport is too close to the top or bottom we need to move unseen objects from bottom to top or top to bottom.

    // create a new matrix

    // fill in the old matrix

    int move = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ToJs {
  int virtualStart = 0; // this can be negative!
  int virtualEnd = 0; // >= start.
  Size viewSize = Size(0, 0);
  // this offset from virtual 0

  Tuple2<int, int> anchor = Tuple2(0, 1);
  // we could have a row that's too big we need to be able to partially scroll it.
  Offset anchorOffset = Offset(0, 0);

  double zoom = 1.0;

  // create and update the objects.
  // the objects are created with grid coordinates and size themselves
  // in that grid.
  List<double> width = []; // sum is virtual size

  List<double> height = []; // this is only for rows in the cache.

  List<int> move = []; // (x,y)->(x,y)

  //List<ToJsMessage> message;
}
