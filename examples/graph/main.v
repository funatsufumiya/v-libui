module main

import libui
import time

__global (
	mainwin       voidptr
	histogram     voidptr
	color_button  voidptr
	datapoints    [10]voidptr
	current_point int
)

const xoff_left = 20
const yoff_top = 20
const xoff_right = 20
const yoff_bottom = 20
const point_radius = 5
const color_white = 0xFFFFFF
const color_black = 0x000000
const color_dodger_blue = 0x1E90FF

fn set_solid_brush(mut brush C.uiDrawBrush, color u32, alpha f64) {
	brush.Type = C.uiDrawBrushTypeSolid
	brush.R = f64((color >> 16) & 0xFF) / 255.0
	brush.G = f64((color >> 8) & 0xFF) / 255.0
	brush.B = f64(color & 0xFF) / 255.0
	brush.A = alpha
}

fn point_locations(width f64, height f64, mut xs []f64, mut ys []f64) {
	xincr := width / 9.0
	yincr := height / 100.0
	for i := 0; i < 10; i++ {
		mut n := C.uiSpinboxValue(datapoints[i])
		n = 100 - n
		xs[i] = xincr * f64(i)
		ys[i] = yincr * f64(n)
	}
}

fn construct_graph(width f64, height f64, extend bool) voidptr {
	mut xs := []f64{len: 10}
	mut ys := []f64{len: 10}
	point_locations(width, height, mut xs, mut ys)
	path := C.uiDrawNewPath(C.uiDrawFillModeWinding)
	C.uiDrawPathNewFigure(path, xs[0], ys[0])
	for i := 1; i < 10; i++ {
		C.uiDrawPathLineTo(path, xs[i], ys[i])
	}
	if extend {
		C.uiDrawPathLineTo(path, width, height)
		C.uiDrawPathLineTo(path, 0, height)
		C.uiDrawPathCloseFigure(path)
	}
	C.uiDrawPathEnd(path)
	return path
}

fn graph_size(client_width f64, client_height f64, mut graph_width &f64, mut graph_height &f64) {
	graph_width = client_width - xoff_left - xoff_right
	graph_height = client_height - yoff_top - yoff_bottom
}

fn handler_draw(a &C.uiAreaHandler, area_ &C.uiArea, p &C.uiAreaDrawParams) {
	mut brush := &C.uiDrawBrush{}
	mut sp := &C.uiDrawStrokeParams{Dashes: unsafe {nil}}
	mut m := &C.uiDrawMatrix{}
	mut graph_width := f64(0)
	mut graph_height := f64(0)

	// fill area with white
	set_solid_brush(mut brush, color_white, 1.0)
	mut path := C.uiDrawNewPath(C.uiDrawFillModeWinding)
	C.uiDrawPathAddRectangle(path, 0, 0, p.AreaWidth, p.AreaHeight)
	C.uiDrawPathEnd(path)
	C.uiDrawFill(p.Context, path, brush)
	C.uiDrawFreePath(path)

	graph_size(p.AreaWidth, p.AreaHeight, mut graph_width, mut graph_height)

	// stroke params
	unsafe { C.memset(sp, 0, sizeof(C.uiDrawStrokeParams)) }
	sp.Cap = libui.uiDrawLineCapFlat
	sp.Join = libui.uiDrawLineJoinMiter
	sp.Thickness = 2
	sp.MiterLimit = libui.uiDrawDefaultMiterLimit

	// draw axes
	set_solid_brush(mut brush, color_black, 1.0)
	path = C.uiDrawNewPath(libui.uiDrawFillModeWinding)
	C.uiDrawPathNewFigure(path, xoff_left, yoff_top)
	C.uiDrawPathLineTo(path, xoff_left, yoff_top + graph_height)
	C.uiDrawPathLineTo(path, xoff_left + graph_width, yoff_top + graph_height)
	C.uiDrawPathEnd(path)
	C.uiDrawStroke(p.Context, path, brush, sp)
	C.uiDrawFreePath(path)

	// transform coordinate space
	C.uiDrawMatrixSetIdentity(m)
	C.uiDrawMatrixTranslate(m, xoff_left, yoff_top)
	C.uiDrawTransform(p.Context, m)

	// get color for graph
	mut graph_r := f64(0)
	mut graph_g := f64(0)
	mut graph_b := f64(0)
	mut graph_a := f64(0)
	C.uiColorButtonColor(color_button, &graph_r, &graph_g, &graph_b, &graph_a)
	brush.Type = C.uiDrawBrushTypeSolid
	brush.R = graph_r
	brush.G = graph_g
	brush.B = graph_b

	// fill graph
	path = construct_graph(graph_width, graph_height, true)
	brush.A = graph_a / 2.0
	C.uiDrawFill(p.Context, path, brush)
	C.uiDrawFreePath(path)

	// draw histogram line
	path = construct_graph(graph_width, graph_height, false)
	brush.A = graph_a
	C.uiDrawStroke(p.Context, path, brush, sp)
	C.uiDrawFreePath(path)

	// draw hovered point
	if current_point != -1 {
		mut xs := []f64{len: 10}
		mut ys := []f64{len: 10}
		point_locations(graph_width, graph_height, mut xs, mut ys)
		path = C.uiDrawNewPath(C.uiDrawFillModeWinding)
		C.uiDrawPathNewFigureWithArc(path, xs[current_point], ys[current_point], point_radius,
			0, 6.23, 0)
		C.uiDrawPathEnd(path)
		C.uiDrawFill(p.Context, path, brush)
		C.uiDrawFreePath(path)
	}
}

fn in_point(x f64, y f64, xtest f64, ytest f64) bool {
	mut x_ := x
	mut y_ := x
	x_ -= xoff_left
	y_ -= yoff_top
	return x_ >= xtest - point_radius && x_ <= xtest + point_radius && y_ >= ytest - point_radius
		&& y_ <= ytest + point_radius
}

fn handler_mouse_event(a &C.uiAreaHandler, area_ &C.uiArea, event &C.uiAreaMouseEvent) {
	mut graph_width := f64(0)
	mut graph_height := f64(0)
	mut xs := []f64{len: 10}
	mut ys := []f64{len: 10}
	graph_size(event.AreaWidth, event.AreaHeight, mut graph_width, mut graph_height)
	point_locations(graph_width, graph_height, mut xs, mut ys)
	mut i := 0
	for ; i < 10; i++ {
		if in_point(event.X, event.Y, xs[i], ys[i]) {
			break
		}
	}
	if i == 10 {
		i = -1
	}
	current_point = i
	C.uiAreaQueueRedrawAll(histogram)
}

fn handler_mouse_crossed(a &C.uiAreaHandler, area_ &C.uiArea, left int) {}

fn handler_drag_broken(a &C.uiAreaHandler, area_ &C.uiArea) {}

fn handler_key_event(a &C.uiAreaHandler, area_ &C.uiArea, e &C.uiAreaKeyEvent) int {
	return 0
}

fn on_datapoint_changed(s &C.uiSpinbox, data voidptr) {
	C.uiAreaQueueRedrawAll(histogram)
}

fn on_color_changed(b &C.uiColorButton, data voidptr) {
	C.uiAreaQueueRedrawAll(histogram)
}

fn on_closing(w &C.uiWindow, data voidptr) int {
	C.uiControlDestroy(libui.uiControl(mainwin))
	C.uiQuit()
	return 0
}

fn should_quit(data voidptr) int {
	C.uiControlDestroy(libui.uiControl(mainwin))
	return 1
}

fn main() {
    // WORKAROUND: in order to suppress time is not used warning
	// NOTE: time module is used to include C.time
    _ := time.now()

	mut o := C.uiInitOptions{}
	unsafe { C.memset(&o, 0, sizeof(C.uiInitOptions)) }
	err := C.uiInit(&o)
	if err != unsafe { nil } {
		println('error initializing ui')
		C.uiFreeInitError(err)
		return
	}

	C.uiOnShouldQuit(should_quit, unsafe { nil })

	mainwin = C.uiNewWindow(c'libui Histogram Example', 640, 480, 1)
	C.uiWindowSetMargined(mainwin, 1)
	C.uiWindowOnClosing(mainwin, on_closing, unsafe { nil })

	hbox := C.uiNewHorizontalBox()
	C.uiBoxSetPadded(hbox, 1)
	C.uiWindowSetChild(mainwin, libui.uiControl(hbox))

	vbox := C.uiNewVerticalBox()
	C.uiBoxSetPadded(vbox, 1)
	C.uiBoxAppend(hbox, libui.uiControl(vbox), 0)

	// datapoints
	C.srand(C.time(unsafe { nil }))
	for i := 0; i < 10; i++ {
		datapoints[i] = C.uiNewSpinbox(0, 100)
		C.uiSpinboxSetValue(datapoints[i], C.rand() % 101)
		C.uiSpinboxOnChanged(datapoints[i], on_datapoint_changed, unsafe { nil })
		C.uiBoxAppend(vbox, libui.uiControl(datapoints[i]), 0)
	}

	// color button
	color_button = C.uiNewColorButton()
	mut brush := &C.uiDrawBrush{}
	set_solid_brush(mut brush, color_dodger_blue, 1.0)
	C.uiColorButtonSetColor(color_button, brush.R, brush.G, brush.B, brush.A)
	C.uiColorButtonOnChanged(color_button, on_color_changed, unsafe { nil })
	C.uiBoxAppend(vbox, libui.uiControl(color_button), 0)

	// area
	mut handler := C.uiAreaHandler{
		Draw:         voidptr(handler_draw)
		MouseEvent:   voidptr(handler_mouse_event)
		MouseCrossed: voidptr(handler_mouse_crossed)
		DragBroken:   voidptr(handler_drag_broken)
		KeyEvent:     voidptr(handler_key_event)
	}
	histogram = C.uiNewArea(&handler)
	C.uiBoxAppend(hbox, libui.uiControl(histogram), 1)

	C.uiControlShow(libui.uiControl(mainwin))
	C.uiMain()
	C.uiUninit()
}
