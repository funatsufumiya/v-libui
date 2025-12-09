module main

import libui

fn on_closing(w &C.uiWindow, data voidptr) int
{
	C.uiQuit()
	return 1
}

fn main() {
	o := C.uiInitOptions{}

	unsafe { C.memset(&o, 0, sizeof (C.uiInitOptions)) }
	if C.uiInit(&o) != unsafe {nil} {
		// C.abort();
		assert(false)
    }

	w := C.uiNewWindow(c"Hello", 320, 240, 0);
	C.uiWindowOnClosing(w, on_closing, unsafe {nil} );
	C.uiControlShow(libui.uiControl(w));
	C.uiMain();
}
