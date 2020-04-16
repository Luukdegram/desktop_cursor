// Copyright (c) 2020 Luuk de Gram
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

/// The possible shapes the cursor can be set to.
enum CursorShape {
  /// OS specific arrow shape.
  arrow,

  /// The `I` shape, also used for editing text.
  iBeam,

  /// The `+` shape.
  crosshair,

  /// The hand shape, often used for buttons and links.
  hand,

  /// The `<-||->` shape. A shape used for resizing horizontally.
  horizontalResize,

  /// The shape used for resizing vertically.
  verticalResize,
}

/// Allows setting and getting the shape of the cursor through the window manager.
class DesktopCursor {
  static const MethodChannel _channel = const MethodChannel('desktop_cursor');

  /// Will try to set the shape of the cursor.
  ///
  /// If [cursor] equals `null`, the shape will be set to `CursorShape.arrowCursor`.
  static Future<void> setShape(CursorShape cursor) {
    return _channel.invokeMethod(
        'setCursor', cursor.index ?? CursorShape.arrow);
  }

  /// The current Shape of the cursor.
  static Future<CursorShape> get currentShape async {
    // Currently we use the index on both Dart and Go side to determine the correct shape.
    // preferably, we want to change this to a more safe way.
    final int index = await _channel.invokeMethod<int>("getCursor");
    return CursorShape.values.elementAt(index);
  }
}

extension CursorShapeHelper on Widget {
  /// This extension allows you to set the cursor while it hovers over the widget.
  ///
  /// This will wrap the widget with [MouseRegion] to set the [CursorShape].
  /// When the cursor exits the widget it will always be set to the default `CursorShape.arrowCursor`
  Widget onHover(CursorShape cursor) {
    return MouseRegion(
      child: this,
      onEnter: (_) => DesktopCursor.setShape(cursor),
      // ArrowCursor is the default cursor so reset it to this.
      onExit: (_) => DesktopCursor.setShape(CursorShape.arrow),
    );
  }
}

/// Wraps a [MouseRegion] around the child where the cursor can be set
/// specifically when the cursor enters and exits the [child] widget.
///
/// If you require to set the shape of the [CursorShape] on mouse button input
/// wrap a widget with [Listener] and use [DesktopCursor.setShape]
class CursorArea extends StatelessWidget {
  const CursorArea({Key key, @required this.child, this.onEnter, this.onExit})
      : super(key: key);
  final Widget child;
  final CursorShape onEnter;
  final CursorShape onExit;

  /// Will only set the cursor if [cursor] does not equal `null`.
  void setCursor(CursorShape cursor) {
    if (cursor == null) {
      return;
    }

    DesktopCursor.setShape(cursor);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: child,
      onEnter: (_) => setCursor(onEnter),
      onExit: (_) => setCursor(CursorShape.arrow),
    );
  }
}
