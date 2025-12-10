module main

import libui

__global (
	mainwin &C.uiWindow
	spinbox &C.uiSpinbox
	slider &C.uiSlider
	pbar &C.uiProgressBar
)

// --- Basic Controls Page ---
fn make_basic_controls_page() &C.uiControl {
	vbox := C.uiNewVerticalBox()
	C.uiBoxSetPadded(vbox, 1)

	hbox := C.uiNewHorizontalBox()
	C.uiBoxSetPadded(hbox, 1)
	C.uiBoxAppend(vbox, libui.uiControl(hbox), 0)

	C.uiBoxAppend(hbox, libui.uiControl(C.uiNewButton(c'Button')), 0)
	C.uiBoxAppend(hbox, libui.uiControl(C.uiNewCheckbox(c'Checkbox')), 0)

	C.uiBoxAppend(vbox, libui.uiControl(C.uiNewLabel(c'This is a label. Right now, labels can only span one line.')), 0)
	C.uiBoxAppend(vbox, libui.uiControl(C.uiNewHorizontalSeparator()), 0)

	group := C.uiNewGroup(c'Entries')
	C.uiGroupSetMargined(group, 1)
	C.uiBoxAppend(vbox, libui.uiControl(group), 1)

	entry_form := C.uiNewForm()
	C.uiFormSetPadded(entry_form, 1)
	C.uiGroupSetChild(group, libui.uiControl(entry_form))

	C.uiFormAppend(entry_form, c'Entry', libui.uiControl(C.uiNewEntry()), 0)
	C.uiFormAppend(entry_form, c'Password Entry', libui.uiControl(C.uiNewPasswordEntry()), 0)
	C.uiFormAppend(entry_form, c'Search Entry', libui.uiControl(C.uiNewSearchEntry()), 0)
	C.uiFormAppend(entry_form, c'Multiline Entry', libui.uiControl(C.uiNewMultilineEntry()), 1)
	C.uiFormAppend(entry_form, c'Multiline Entry No Wrap', libui.uiControl(C.uiNewNonWrappingMultilineEntry()), 1)

	return libui.uiControl(vbox)
}

// --- Numbers and Lists Page ---
fn on_spinbox_changed(s &C.uiSpinbox, data voidptr) {
	C.uiSliderSetValue(slider, C.uiSpinboxValue(s))
	C.uiProgressBarSetValue(voidptr(pbar), C.uiSpinboxValue(s)) // WORKAROUND voidptr is guide for tcc
}

fn on_slider_changed(s &C.uiSlider, data voidptr) {
	C.uiSpinboxSetValue(spinbox, C.uiSliderValue(s))
	C.uiProgressBarSetValue(voidptr(pbar), C.uiSliderValue(s)) // WORKAROUND voidptr is guide for tcc
}

fn make_numbers_page() &C.uiControl {
	hbox := C.uiNewHorizontalBox()
	C.uiBoxSetPadded(hbox, 1)

	group := C.uiNewGroup(c'Numbers')
	C.uiGroupSetMargined(group, 1)
	C.uiBoxAppend(hbox, libui.uiControl(group), 1)

	vbox := C.uiNewVerticalBox()
	C.uiBoxSetPadded(vbox, 1)
	C.uiGroupSetChild(group, libui.uiControl(vbox))

	spinbox = C.uiNewSpinbox(0, 100)
	slider = C.uiNewSlider(0, 100)
	pbar = C.uiNewProgressBar()
	C.uiSpinboxOnChanged(spinbox, on_spinbox_changed, unsafe { nil })
	C.uiSliderOnChanged(slider, on_slider_changed, unsafe { nil })
	C.uiBoxAppend(vbox, libui.uiControl(spinbox), 0)
	C.uiBoxAppend(vbox, libui.uiControl(slider), 0)
	C.uiBoxAppend(vbox, libui.uiControl(voidptr(pbar)), 0) // WORKAROUND voidptr is guide for tcc

	ip := C.uiNewProgressBar()
	C.uiProgressBarSetValue(voidptr(ip), -1) // WORKAROUND: voidptr is guide for tcc
	C.uiBoxAppend(vbox, libui.uiControl(ip), 0)

	group2 := C.uiNewGroup(c'Lists')
	C.uiGroupSetMargined(group2, 1)
	C.uiBoxAppend(hbox, libui.uiControl(group2), 1)

	vbox2 := C.uiNewVerticalBox()
	C.uiBoxSetPadded(vbox2, 1)
	C.uiGroupSetChild(group2, libui.uiControl(vbox2))

	cbox := C.uiNewCombobox()
	C.uiComboboxAppend(cbox, c'Combobox Item 1')
	C.uiComboboxAppend(cbox, c'Combobox Item 2')
	C.uiComboboxAppend(cbox, c'Combobox Item 3')
	C.uiBoxAppend(vbox2, libui.uiControl(cbox), 0)

	ecbox := C.uiNewEditableCombobox()
	C.uiEditableComboboxAppend(ecbox, c'Editable Item 1')
	C.uiEditableComboboxAppend(ecbox, c'Editable Item 2')
	C.uiEditableComboboxAppend(ecbox, c'Editable Item 3')
	C.uiBoxAppend(vbox2, libui.uiControl(ecbox), 0)

	rb := C.uiNewRadioButtons()
	C.uiRadioButtonsAppend(rb, c'Radio Button 1')
	C.uiRadioButtonsAppend(rb, c'Radio Button 2')
	C.uiRadioButtonsAppend(rb, c'Radio Button 3')
	C.uiBoxAppend(vbox2, libui.uiControl(rb), 0)

	return libui.uiControl(hbox)
}

// --- Data Choosers Page ---
fn on_open_file_clicked(b &C.uiButton, data voidptr) {
	entry := data
	filename := C.uiOpenFile(mainwin)
	if filename == unsafe { nil } {
		C.uiEntrySetText(entry, c'(cancelled)')
		return
	}
	C.uiEntrySetText(entry, filename)
	C.uiFreeText(filename)
}

fn on_save_file_clicked(b &C.uiButton, data voidptr) {
	entry := data
	filename := C.uiSaveFile(mainwin)
	if filename == unsafe { nil } {
		C.uiEntrySetText(entry, c'(cancelled)')
		return
	}
	C.uiEntrySetText(entry, filename)
	C.uiFreeText(filename)
}

fn on_msg_box_clicked(b &C.uiButton, data voidptr) {
	C.uiMsgBox(mainwin, c'This is a normal message box.', c'More detailed information can be shown here.')
}

fn on_msg_box_error_clicked(b &C.uiButton, data voidptr) {
	C.uiMsgBoxError(mainwin, c'This message box describes an error.', c'More detailed information can be shown here.')
}

fn make_data_choosers_page() &C.uiControl {
	hbox := C.uiNewHorizontalBox()
	C.uiBoxSetPadded(hbox, 1)

	vbox := C.uiNewVerticalBox()
	C.uiBoxSetPadded(vbox, 1)
	C.uiBoxAppend(hbox, libui.uiControl(vbox), 0)

	C.uiBoxAppend(vbox, libui.uiControl(C.uiNewDatePicker()), 0)
	C.uiBoxAppend(vbox, libui.uiControl(C.uiNewTimePicker()), 0)
	C.uiBoxAppend(vbox, libui.uiControl(C.uiNewDateTimePicker()), 0)
	C.uiBoxAppend(vbox, libui.uiControl(C.uiNewFontButton()), 0)
	C.uiBoxAppend(vbox, libui.uiControl(C.uiNewColorButton()), 0)

	C.uiBoxAppend(hbox, libui.uiControl(C.uiNewVerticalSeparator()), 0)

	vbox2 := C.uiNewVerticalBox()
	C.uiBoxSetPadded(vbox2, 1)
	C.uiBoxAppend(hbox, libui.uiControl(vbox2), 1)

	grid := C.uiNewGrid()
	C.uiGridSetPadded(grid, 1)
	C.uiBoxAppend(vbox2, libui.uiControl(grid), 0)

	button := C.uiNewButton(c'Open File')
	entry := C.uiNewEntry()
	C.uiEntrySetReadOnly(entry, 1)
	C.uiButtonOnClicked(button, on_open_file_clicked, entry)
	C.uiGridAppend(grid, libui.uiControl(button), 0, 0, 1, 1, 0, C.uiAlignFill, 0, C.uiAlignFill)
	C.uiGridAppend(grid, libui.uiControl(entry), 1, 0, 1, 1, 1, C.uiAlignFill, 0, C.uiAlignFill)

	button2 := C.uiNewButton(c'Save File')
	entry2 := C.uiNewEntry()
	C.uiEntrySetReadOnly(entry2, 1)
	C.uiButtonOnClicked(button2, on_save_file_clicked, entry2)
	C.uiGridAppend(grid, libui.uiControl(button2), 0, 1, 1, 1, 0, C.uiAlignFill, 0, C.uiAlignFill)
	C.uiGridAppend(grid, libui.uiControl(entry2), 1, 1, 1, 1, 1, C.uiAlignFill, 0, C.uiAlignFill)

	msggrid := C.uiNewGrid()
	C.uiGridSetPadded(msggrid, 1)
	C.uiGridAppend(grid, libui.uiControl(msggrid), 0, 2, 2, 1, 0, C.uiAlignCenter, 0, C.uiAlignStart)

	msg_btn := C.uiNewButton(c'Message Box')
	C.uiButtonOnClicked(msg_btn, on_msg_box_clicked, unsafe { nil })
	C.uiGridAppend(msggrid, libui.uiControl(msg_btn), 0, 0, 1, 1, 0, C.uiAlignFill, 0, C.uiAlignFill)
	msg_err_btn := C.uiNewButton(c'Error Box')
	C.uiButtonOnClicked(msg_err_btn, on_msg_box_error_clicked, unsafe { nil })
	C.uiGridAppend(msggrid, libui.uiControl(msg_err_btn), 1, 0, 1, 1, 0, C.uiAlignFill, 0, C.uiAlignFill)

	return libui.uiControl(hbox)
}

// --- Window Events ---
fn on_closing(w &C.uiWindow, data voidptr) int {
	C.uiQuit()
	return 1
}

fn should_quit(data voidptr) int {
	C.uiControlDestroy(libui.uiControl(mainwin))
	return 1
}

// --- Main ---
fn main() {
	mut options := C.uiInitOptions{}
	err := C.uiInit(&options)
	if err != unsafe { nil } {
		println('error initializing libui')
		C.uiFreeInitError(err)
		return
	}

	mainwin = C.uiNewWindow(c'libui Control Gallery', 640, 480, 1)
	C.uiWindowOnClosing(mainwin, on_closing, unsafe { nil })
	C.uiOnShouldQuit(should_quit, mainwin)

	tab := C.uiNewTab()
	C.uiWindowSetChild(mainwin, libui.uiControl(tab))
	C.uiWindowSetMargined(mainwin, 1)

	C.uiTabAppend(tab, c'Basic Controls', make_basic_controls_page())
	C.uiTabSetMargined(tab, 0, 1)

	C.uiTabAppend(tab, c'Numbers and Lists', make_numbers_page())
	C.uiTabSetMargined(tab, 1, 1)

	C.uiTabAppend(tab, c'Data Choosers', make_data_choosers_page())
	C.uiTabSetMargined(tab, 2, 1)

	C.uiControlShow(libui.uiControl(mainwin))
	C.uiMain()
	C.uiUninit()
}
