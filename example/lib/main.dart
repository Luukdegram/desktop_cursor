import 'package:flutter/material.dart';

import 'package:desktop_cursor/desktop_cursor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                onPressed: () =>
                    DesktopCursor.currentShape.then((cursor) => print(cursor)),
                child: Text("Hover over me"),
              ).onHover(CursorShape.hand),
              CursorArea(
                onEnter: CursorShape.crosshair,
                onExit: CursorShape.arrow,
                child: MaterialButton(
                  onPressed: () => null,
                  child: Text("This one uses CursorShape widget"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
