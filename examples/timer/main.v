module main

import libui
import time

__global (
    e mut voidptr
)

fn say_time(data voidptr) int {
    t := time.now()
    s := t.str() + '\n'
    C.uiMultilineEntryAppend(e, s.str)
    return 1
}

fn on_closing(w &C.uiWindow, data voidptr) int {
    C.uiQuit()
    return 1
}

fn say_something(b &C.uiButton, data voidptr) {
    C.uiMultilineEntryAppend(e, c'Saying something\n')
}

fn main() {
    mut o := C.uiInitOptions{}
    unsafe { C.memset(&o, 0, sizeof(C.uiInitOptions)) }
    if C.uiInit(&o) != unsafe { nil } {
        assert(false)
    }

    w := C.uiNewWindow(c'Hello', 320, 240, 0)
    C.uiWindowSetMargined(w, 1)

    b := C.uiNewVerticalBox()
    C.uiBoxSetPadded(b, 1)
    C.uiWindowSetChild(w, libui.uiControl(b))

    e = voidptr(C.uiNewMultilineEntry())
    C.uiMultilineEntrySetReadOnly(e, 1)

    btn := C.uiNewButton(c'Say Something')
    C.uiButtonOnClicked(btn, say_something, unsafe { nil })
    C.uiBoxAppend(b, libui.uiControl(btn), 0)

    C.uiBoxAppend(b, libui.uiControl(e), 1)

    C.uiTimer(1000, say_time, unsafe { nil })

    C.uiWindowOnClosing(w, on_closing, unsafe { nil })
    C.uiControlShow(libui.uiControl(w))
    C.uiMain()
}