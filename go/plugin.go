// Copyright (c) 2020 Luuk de Gram
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

package desktop_cursor

import (
	"fmt"

	flutter "github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
	"github.com/go-gl/glfw/v3.3/glfw"
)

const channelName = "desktop_cursor"

type cursor = int32

const (
	arrowCursor cursor = iota
	iBeamCursor
	crosshairCursor
	handCursor
	hResizeCursor
	vResizeCursor
)

// DesktopCursorPlugin implements flutter.Plugin and handles method.
type DesktopCursorPlugin struct {
	w *glfw.Window
	c cursor
}

var _ flutter.Plugin = &DesktopCursorPlugin{}     // compile-time type check
var _ flutter.PluginGLFW = &DesktopCursorPlugin{} // compile-time type check

// InitPlugin initializes the plugin.
func (p *DesktopCursorPlugin) InitPlugin(messenger plugin.BinaryMessenger) error {
	channel := plugin.NewMethodChannel(messenger, channelName, plugin.StandardMethodCodec{})
	channel.HandleFuncSync("setCursor", p.setCursor)
	channel.HandleFunc("getCursor", p.getCursor)
	return nil
}

// InitPluginGLFW saves the GLFW window to the plugin which can then be used to set the cursor
func (p *DesktopCursorPlugin) InitPluginGLFW(window *glfw.Window) error {
	p.w = window
	p.c = arrowCursor
	return nil
}

// setCursor will set the shape of the cursor. i.e. a hand cursor.
func (p *DesktopCursorPlugin) setCursor(arguments interface{}) (interface{}, error) {
	value, ok := arguments.(cursor)
	if !ok {
		return nil, fmt.Errorf("Invalid value %v. This is not an integer", value)
	}

	cursor, ok := mapToGlfw[value]
	if !ok {
		return nil, fmt.Errorf("Index out of bounds for value %v. Could not find a shape for this value", value)
	}

	c := glfw.CreateStandardCursor(cursor)
	p.w.SetCursor(c)
	p.c = value
	return nil, nil
}

// getCursor returns the current shape of the cursor. i.e. a crosshair cursor
func (p *DesktopCursorPlugin) getCursor(arguments interface{}) (interface{}, error) {
	return p.c, nil
}

var mapToGlfw = map[cursor]glfw.StandardCursor{
	arrowCursor:     glfw.ArrowCursor,
	iBeamCursor:     glfw.IBeamCursor,
	crosshairCursor: glfw.CrosshairCursor,
	handCursor:      glfw.HandCursor,
	hResizeCursor:   glfw.HResizeCursor,
	vResizeCursor:   glfw.VResizeCursor,
}
