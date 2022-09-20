// a database file system and xx
// write in generations
// manage spreadsheets

// a document section/chapter is just a cell in a spreadsheet?
// what is a spine then? maybe a document is always a single cell sheet.

// Segments are split into pages, they are immutable. We don't need to load them entirely into memory, but they are built in memory before merging.
// segments have unique (btree) index and non-unique (posting style) indices.
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class Db {
  observe(RangeDesc ) {
    
  }
}

class Tx {
  commit()
}

class Bytes implements Comparable {
  late Uint8List data;
  static final empty = Bytes(Uint8List(0));

  Bytes(this.data);

  @override
  int get hashCode => 0;
  @override
  bool operator ==(Object other) =>
      other is Bytes && listEquals(data, other.data);

  Bytes operator +(Bytes b) => Bytes(Uint8List.fromList([...data, ...b.data]));

  @override
  int compareTo(other) {
    if (!other is Bytes) throw "not bytes";
    final b = other as Bytes;
    int m = min(b.data.length, data.length);
    for (int i=0; i<m; i++ ){
      final ix = data[i].compareTo(b.data[i]);
      if (ix!=0) {return ix;}
    }
    return data.length < b.data.length ? -1 : (data.length==b.data.length?0:1)
  }
}

// ranges are indices.
class Index {
  // an index can be unique or non-unique.
  bool unique = true;

}
class Tuple {
  DatumId did = DatumId.empty;
  BranchId bid = BranchId.empty;
  Lsn lsn = Bytes.empty;

  Map<String, dynamic> data = {};
}


class Segment {
  findTerm(String field, String value) {}

  Tuple getTuple(Bytes b) {
    return Tuple();
  }
}

typedef DatumId = Bytes;
typedef BranchId = Bytes;
typedef Lsn = Bytes;

class Branch {

}
class RangeDesc {
  Index index;
  Uint8List from;
  Uint8List? to;
  int limit = 200;
  RangeDesc({
    required this.index,
    required this.from, 
    this.to,
    this.limit = 200
});

}

class Observer {


}

// can we prepare a query like this? seems like we need to be able to modify the query as we go, but we could probably reoptimize it.
// class PreparedQuery<Params, Result> {

//   open(Params, Result )

//   static PreparedQuery prepare(String query) {
//     return PreparedQuery();
//   }
// }

// admin, readers. writers are by branch


// spreadsheet style should probably be in a proto?
//
enum LayoutStyle {
  viewPortRelative,
  viewPortIndependent,
}

// mostly used through spreadsheets?
class Query {}

class Spreadsheet {
  List<GridStyle> column = [];
  int firstRow = 0;
  // this can only be an estimate if grid is viewport relative.
  double offsetFirstRow = 0;
  List<GridStyle> row = [];
  List<FloatObject> object = [];

  // do we need to map the id back to a row?
  Map<int, Cell> cell = {};

  static Spreadsheet open(Db db) {
    return Spreadsheet();
  }
}

// when we insert we need to move these down.
abstract class FloatObject {
  int rowAnchor = 0;
  double columnOffset = 0;
}

// a canvas has a generic locked object layer for charts etc.
// these are anchored to a row, but not a column.
abstract class Cell {}

class GridStyle {
  int id = 0;
}

class SpreadsheetList {
  List<Spreadsheet> spreadsheet = [];
}
