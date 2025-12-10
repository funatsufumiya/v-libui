module main

import libui

__global (
    mainwin voidptr
    area voidptr
    font_button voidptr
    alignment voidptr
    attrstr voidptr
)

fn append_with_attribute(what string, attr voidptr, attr2 voidptr) {
    start := C.uiAttributedStringLen(attrstr)
    end := int(start) + what.len
    C.uiAttributedStringAppendUnattributed(attrstr, what.str)
    C.uiAttributedStringSetAttribute(attrstr, attr, start, end)
    if attr2 != unsafe { nil } {
        C.uiAttributedStringSetAttribute(attrstr, attr2, start, end)
    }
}

fn make_attributed_string() {
    // mut attr := voidptr(0)
    mut attr := voidptr(0)
    mut attr2 := voidptr(0)
    mut otf := voidptr(0)
    attrstr = C.uiNewAttributedString(
        c"Drawing strings with libui is done with the uiAttributedString and uiDrawTextLayout objects.\n"
        // c"uiAttributedString lets you have a variety of attributes: "
    )

    attr = C.uiNewFamilyAttribute(c"Courier New")
    append_with_attribute("font family", attr, unsafe { nil })
    C.uiAttributedStringAppendUnattributed(attrstr, c", ")

    attr = C.uiNewSizeAttribute(18)
    append_with_attribute("font size", attr, unsafe { nil })
    C.uiAttributedStringAppendUnattributed(attrstr, c", ")

    attr = C.uiNewWeightAttribute(C.uiTextWeightBold)
    append_with_attribute("font weight", attr, unsafe { nil })
    C.uiAttributedStringAppendUnattributed(attrstr, c", ")

    attr = C.uiNewItalicAttribute(C.uiTextItalicItalic)
    append_with_attribute("font italicness", attr, unsafe { nil })
    C.uiAttributedStringAppendUnattributed(attrstr, c", ")

    attr = C.uiNewStretchAttribute(C.uiTextStretchCondensed)
    append_with_attribute("font stretch", attr, unsafe { nil })
    C.uiAttributedStringAppendUnattributed(attrstr, c", ")

    attr = C.uiNewColorAttribute(0.75, 0.25, 0.5, 0.75)
    append_with_attribute("text color", attr, unsafe { nil })
    C.uiAttributedStringAppendUnattributed(attrstr, c", ")

    attr = C.uiNewBackgroundAttribute(0.5, 0.5, 0.25, 0.5)
    append_with_attribute("text background color", attr, unsafe { nil })
    C.uiAttributedStringAppendUnattributed(attrstr, c", ")

    attr = C.uiNewUnderlineAttribute(C.uiUnderlineSingle)
    append_with_attribute("underline style", attr, unsafe { nil })
    C.uiAttributedStringAppendUnattributed(attrstr, c", ")

    C.uiAttributedStringAppendUnattributed(attrstr, c"and ")
    attr = C.uiNewUnderlineAttribute(C.uiUnderlineDouble)
    attr2 = C.uiNewUnderlineColorAttribute(C.uiUnderlineColorCustom, 1.0, 0.0, 0.5, 1.0)
    append_with_attribute("underline color", attr, attr2)
    C.uiAttributedStringAppendUnattributed(attrstr, c". ")

    C.uiAttributedStringAppendUnattributed(attrstr, c"Furthermore, there are attributes allowing for ")
    attr = C.uiNewUnderlineAttribute(C.uiUnderlineSuggestion)
    attr2 = C.uiNewUnderlineColorAttribute(C.uiUnderlineColorSpelling, 0, 0, 0, 0)
    append_with_attribute("special underlines for indicating spelling errors", attr, attr2)
    C.uiAttributedStringAppendUnattributed(attrstr, c" (and other types of errors) ")

    C.uiAttributedStringAppendUnattributed(attrstr, c"and control over OpenType features such as ligatures (for instance, ")
    otf = C.uiNewOpenTypeFeatures()
    C.uiOpenTypeFeaturesAdd(otf, i8('l'[0]), i8('i'[0]), i8('g'[0]), i8('a'[0]), 0)
    attr = C.uiNewFeaturesAttribute(otf)
    append_with_attribute("afford", attr, unsafe { nil })
    C.uiAttributedStringAppendUnattributed(attrstr, c" vs. ")
    C.uiOpenTypeFeaturesAdd(otf, i8('l'[0]), i8('i'[0]), i8('g'[0]), i8('a'[0]), 1)
    attr = C.uiNewFeaturesAttribute(otf)
    append_with_attribute("afford", attr, unsafe { nil })
    C.uiFreeOpenTypeFeatures(otf)
    C.uiAttributedStringAppendUnattributed(attrstr, c").\n")

    C.uiAttributedStringAppendUnattributed(attrstr, c"Use the controls opposite to the text to control properties of the text.")
}

fn handler_draw(a voidptr, area_ voidptr, p &C.uiAreaDrawParams) {
    mut text_layout := voidptr(0)
    mut default_font := &C.uiFontDescriptor{Family: c''}
    mut params := C.uiDrawTextLayoutParams{
		String: attrstr,
		DefaultFont: voidptr(default_font), // WORKAROUND for tcc
		Width: p.AreaWidth,
		Align: C.uiComboboxSelected(alignment)
	}
	C.uiFontButtonFont(font_button, default_font)
    text_layout = C.uiDrawNewTextLayout(&params)
    C.uiDrawText(p.Context, text_layout, 0, 0)
    C.uiDrawFreeTextLayout(text_layout)
    C.uiFreeFontButtonFont(default_font)
}

fn handler_mouse_event(a &C.uiAreaHandler, area_ voidptr, e voidptr) {}
fn handler_mouse_crossed(a &C.uiAreaHandler, area_ voidptr, left int) {}
fn handler_drag_broken(a &C.uiAreaHandler, area_ voidptr) {}
fn handler_key_event(a &C.uiAreaHandler, area_ voidptr, e voidptr) int { return 0 }

fn on_font_changed(b &C.uiFontButton, data voidptr) {
    C.uiAreaQueueRedrawAll(area)
}

fn on_combobox_selected(b &C.uiCombobox, data voidptr) {
    C.uiAreaQueueRedrawAll(area)
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
    mut o := C.uiInitOptions{}
    unsafe { C.memset(&o, 0, sizeof(C.uiInitOptions)) }
    err := C.uiInit(&o)
    if err != unsafe { nil } {
        println('error initializing ui')
        C.uiFreeInitError(err)
        return
    }

    C.uiOnShouldQuit(should_quit, unsafe { nil })

    make_attributed_string()

    mainwin = C.uiNewWindow(c"libui Text-Drawing Example", 640, 480, 1)
    C.uiWindowSetMargined(mainwin, 1)
    C.uiWindowOnClosing(mainwin, on_closing, unsafe { nil })

    hbox := C.uiNewHorizontalBox()
    C.uiBoxSetPadded(hbox, 1)
    C.uiWindowSetChild(mainwin, libui.uiControl(hbox))

    vbox := C.uiNewVerticalBox()
    C.uiBoxSetPadded(vbox, 1)
    C.uiBoxAppend(hbox, libui.uiControl(vbox), 0)

    font_button = C.uiNewFontButton()
    C.uiFontButtonOnChanged(font_button, on_font_changed, unsafe { nil })
    C.uiBoxAppend(vbox, libui.uiControl(font_button), 0)

    form := C.uiNewForm()
    C.uiFormSetPadded(form, 1)
    C.uiBoxAppend(vbox, libui.uiControl(form), 0)

    alignment = C.uiNewCombobox()
    C.uiComboboxAppend(alignment, c"Left")
    C.uiComboboxAppend(alignment, c"Center")
    C.uiComboboxAppend(alignment, c"Right")
    C.uiComboboxSetSelected(alignment, 0)
    C.uiComboboxOnSelected(alignment, on_combobox_selected, unsafe { nil })
    C.uiFormAppend(form, c"Alignment", libui.uiControl(alignment), 0)

    // AreaHandler struct
    mut handler := C.uiAreaHandler{
        Draw: voidptr(handler_draw)
        MouseEvent: voidptr(handler_mouse_event)
        MouseCrossed: voidptr(handler_mouse_crossed)
        DragBroken: voidptr(handler_drag_broken)
        KeyEvent: voidptr(handler_key_event)
    }

    area = C.uiNewArea(&handler)
    C.uiBoxAppend(hbox, libui.uiControl(area), 1)

    C.uiControlShow(libui.uiControl(mainwin))
    C.uiMain()
    C.uiFreeAttributedString(attrstr)
    C.uiUninit()
}
