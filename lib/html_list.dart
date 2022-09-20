import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

import 'div.dart';

class Db {
  ListObserver<T> observe<T>(Query<T> q) {
    return ListObserver<T>((int snapshot, int begin, int end) {
      return [];
    });
  }
}

class Query<T> {}

// Each item of the list needs to be able configure a variety of events that can report back outside the view controller.

// the common case though is a single menu activated by a long press or a hover revealed button. (also right click)
// but also swipe effects and download / share buttons.
// <x @click='send(3)'>
// should we try to send html text or json virtual dom?
// create(" onclick=' ' ", (){ } ), animateTo( )
// it's cheaper to have a single event listener for the entire list.
// data-item='xx' -> send event.

// we are going to get our updates from the database which we can then

// wrap Uint8List to give it equality and hashes

// Maybe
class ListObserver<T> extends ChangeNotifier {
  List<Replace<T>> delta = [];
  int version = 0;
  int length = 0;

  List<T> Function(int snapshot, int begin, int end) load;
  ListObserver(this.load);

  anchor(int y) {}
}

class HtmlScrollController {
  int anchor = 0;
  double offset = 0;

  scrollTo(int x) {}
}

// is the normal builder enough? a controller might avoid the animated list complexity
//
class HtmlList<T> extends StatefulWidget {
  String Function(T data, int index, int version) builder;
  ListObserver<T> observer;
  HtmlScrollController? controller;

  HtmlList({
    required this.observer,
    required this.builder,
  });
  @override
  State<HtmlList<T>> createState() => _HtmlListState<T>();
}

class _HtmlListState<T> extends State<HtmlList<T>> {
  final div = EditorDiv(onMessage: (HtmlMessage e) {});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return div.widget;
  }
}

class HtmGrid<T> extends StatefulWidget {
  ListObserver<Uint8List> rowList, colList;
  ValueObserver<T> value;

  HtmGrid({super.key, required this.rowList, required this.colList});

  @override
  State<HtmGrid<T>> createState() => _HtmGridState<T>();
}

class _HtmGridState<T> extends State<HtmGrid<T>> {
  final div = EditorDiv(onMessage: (HtmlMessage e) {});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

List<String> testHtml = List<String>.generate(100, (e) => "Item $e");

class SimpleHtmlList extends StatefulWidget {
  List<String> html;
  SimpleHtmlList({required this.html});

  @override
  State<SimpleHtmlList> createState() => _SimpleHtmlListState();
}

class _SimpleHtmlListState extends State<SimpleHtmlList> {
  late ListObserver<String> observer;

  @override
  void initState() {
    super.initState();
    observer = ListObserver<String>(
        ((snapshot, begin, end) => widget.html.sublist(begin, end)));
  }

  @override
  Widget build(BuildContext context) {
    return HtmlList(
        builder: (String s, int index, int version) {
          return s;
        },
        observer: observer);
  }
}

class PositionMap {}
