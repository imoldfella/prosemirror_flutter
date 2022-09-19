library prosemirror_flutter;

// we have a webview that's full of editors
// each editor has a root, where typically codemirror or prosemirror is mounted
// we need a channel to each .

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

export 'prosemirror.dart';
export 'codemirror.dart';
export 'editor_list.dart';
export 'div.dart';
export 'chat.dart';
export 'html.dart';
