module main

import libui
import time

__global (
    dtboth voidptr
    dtdate voidptr
    dttime voidptr
)

fn time_format(d voidptr) string {
    if d == dtboth {
        return '%c'
    } else if d == dtdate {
        return '%x'
    } else if d == dttime {
        return '%X'
    }
    return ''
}

fn on_changed(d voidptr, data voidptr) {
    mut tm := C.tm{}
    C.uiDateTimePickerTime(d, &tm)
    buf := [64]u8{}
    fmt := time_format(d)
    C.strftime(&buf[0], buf.len, fmt.str, &tm)
    C.uiLabelSetText(data, &buf[0])
}

fn on_clicked(b voidptr, data voidptr) {
    now := int(data)
    mut t := int(0)
    if now != 0 {
        t = C.time(unsafe { nil })
    }
    tmbuf_ptr := C.localtime(voidptr(&t))
    mut tmbuf := C.tm{}
    if tmbuf_ptr != unsafe { nil } {
        tmbuf = *tmbuf_ptr
    }
    if now != 0 {
        C.uiDateTimePickerSetTime(dtdate, &tmbuf)
        C.uiDateTimePickerSetTime(dttime, &tmbuf)
    } else {
        C.uiDateTimePickerSetTime(dtboth, &tmbuf)
    }
}

fn on_closing(w voidptr, data voidptr) int {
    C.uiQuit()
    return 1
}

fn main() {
    mut o := C.uiInitOptions{}
    unsafe { C.memset(&o, 0, sizeof(C.uiInitOptions)) }
    err := C.uiInit(&o)
    if err != unsafe { nil } {
        println('error initializing ui')
        C.uiFreeInitError(err)
        return
    }

    w := C.uiNewWindow(c'Date / Time', 320, 240, 0)
    C.uiWindowSetMargined(w, 1)

    g := C.uiNewGrid()
    C.uiGridSetPadded(g, 1)
    C.uiWindowSetChild(w, libui.uiControl(g))

    dtboth = C.uiNewDateTimePicker()
    dtdate = C.uiNewDatePicker()
    dttime = C.uiNewTimePicker()

    C.uiGridAppend(g, libui.uiControl(dtboth), 0, 0, 2, 1, 1, C.uiAlignFill, 0, C.uiAlignFill)
    C.uiGridAppend(g, libui.uiControl(dtdate), 0, 1, 1, 1, 1, C.uiAlignFill, 0, C.uiAlignFill)
    C.uiGridAppend(g, libui.uiControl(dttime), 1, 1, 1, 1, 1, C.uiAlignFill, 0, C.uiAlignFill)

    l1 := C.uiNewLabel(c'')
    C.uiGridAppend(g, libui.uiControl(l1), 0, 2, 2, 1, 1, C.uiAlignCenter, 0, C.uiAlignFill)
    C.uiDateTimePickerOnChanged(dtboth, on_changed, l1)

    l2 := C.uiNewLabel(c'')
    C.uiGridAppend(g, libui.uiControl(l2), 0, 3, 1, 1, 1, C.uiAlignCenter, 0, C.uiAlignFill)
    C.uiDateTimePickerOnChanged(dtdate, on_changed, l2)

    l3 := C.uiNewLabel(c'')
    C.uiGridAppend(g, libui.uiControl(l3), 1, 3, 1, 1, 1, C.uiAlignCenter, 0, C.uiAlignFill)
    C.uiDateTimePickerOnChanged(dttime, on_changed, l3)

    b1 := C.uiNewButton(c'Now')
    C.uiButtonOnClicked(b1, on_clicked, voidptr(1))
    C.uiGridAppend(g, libui.uiControl(b1), 0, 4, 1, 1, 1, C.uiAlignFill, 1, C.uiAlignEnd)

    b2 := C.uiNewButton(c'Unix epoch')
    C.uiButtonOnClicked(b2, on_clicked, voidptr(0))
    C.uiGridAppend(g, libui.uiControl(b2), 1, 4, 1, 1, 1, C.uiAlignFill, 1, C.uiAlignEnd)

    C.uiWindowOnClosing(w, on_closing, unsafe { nil })
    C.uiControlShow(libui.uiControl(w))
    C.uiMain()
}