# desktop_cursor

Flutter plugin which allows the developer to set the shape of the cursor on Desktop.
Linux, Windows and MacOs are all supported. The native side is implemented using [go-flutter](hhttps://github.com/go-flutter-desktop/go-flutter). To get setup and running using go-flutter I recommend getting started with its [examples](https://github.com/go-flutter-desktop/examples).

- [desktop_cursor](#desktopcursor)
  - [Getting Started](#getting-started)
    - [Flutter](#flutter)
    - [Desktop](#desktop)
  - [Usage example](#usage-example)
    - [Setting the shape](#setting-the-shape)
    - [Retrieving the current shape](#retrieving-the-current-shape)
    - [onHover extension](#onhover-extension)
    - [CursorArea widget](#cursorarea-widget)


## Getting Started

### Flutter

In your flutter project add the dependency:

```yml
dependencies:
  ...
  desktop_cursor: ^0.1.0
```

For help getting started with Flutter, view the online
[documentation](https://flutter.io/).

### Desktop
For installing and using the go implementation of the plugin, please read the [README](https://github.com/luukdegram/desktop_cursor/go).

## Usage example

An example with all features implemented can be found [here](https://github.com/luukdegram/desktop_cursor/example).

Import `desktop_cursor.dart`

```dart
import 'package:desktop_cursor/desktop_cursor.dart';
```

### Setting the shape
Currently go-lang only supports [GLFW](https://www.glfw.org/). Although GLFW allows for custom shapes, this library currently only supports its standard [shapes](https://www.glfw.org/docs/3.3/group__shapes.html):

* ArrowCursor
* IBeamCursor
* CrosshairCursor
* HandCursor
* HResizeCursor
* VResizeCursor

```Dart
DesktopCursor.setShape(CursorShape.hand);
```

### Retrieving the current shape

This will provide the current shape of the Cursor. Note that by default it will return `CursorShape.arrowCursor`

```Dart
CursorShape shape;
try{
    shape = await DesktopCursor.currentShape;
} on PlatformException{
    print("Could not get the shape");
}
```

### onHover extension

desktop_cursor provides a helper extension to set the cursor when hovering over any Widget.
This extension wraps the widget inside a `MouseRegion`.

*NOTE: When the cursor leaves the widget, the shape will always be set to `CursorShape.arrow`.*

```Dart
...
IconButton(
    ...
).onHover(CursorShape.hoverCursor)
...
```

### CursorArea widget

When requirements demand to be more flexible regarding when to set the shape and to which shape or simply prever to implement it declaratively, the widget `CursorArea` can be used. This widget wraps the provided child widget with `Listener`, and sets the onEnter and onExit variables.

```Dart
...
CursorArea(
    onEnter: CursorShape.crosshair,
    onExit: CursorShape.arrow,
    child: Text("Shoot me")
)
...
```





