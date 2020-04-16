# desktop_cursor

This Go package implements the host-side of the Flutter [desktop_cursor](https://github.com/luukdegram/desktop_cursor) plugin.

## Usage

Import as:

```go
import desktop_cursor "github.com/luukdegram/desktop_cursor/go"
```

Then add the following option to your go-flutter [application options](https://github.com/go-flutter-desktop/go-flutter/wiki/Plugin-info):

```go
flutter.AddPlugin(&desktop_cursor.DesktopCursorPlugin{}),
```