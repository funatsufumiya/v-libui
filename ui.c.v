@[translated]
module libui

#flag -I @VMODROOT

#flag -L @VMODROOT/bin
#flag -lui

#include <string.h>
#include <stdlib.h>
#include "ui.h"
#include "ui_helper.h"

// 6 april 2015
// TODO add a uiVerifyControlType() function that can be used by control implementations to verify controls
// TODOs
// - make getters that return whether something exists accept a NULL pointer to discard the value (and thus only return that the thing exists?)
// - const-correct everything
// - normalize documentation between typedefs and structs
// #ifndef __LIBUI_UI_H__
// #define __LIBUI_UI_H__
// C++ is really really really really really really dumb about enums, so screw that and just make them anonymous
// This has the advantage of being ABI-able should we ever need an ABI...
// This constant is provided because M_PI is nonstandard.
// This comes from Go's math.Pi, which in turn comes from http://oeis.org/A000796.
// TODO uiBool?
// uiForEach represents the return value from one of libui's various ForEach functions.
// _UI_ENUM(uiForEach) {
// 	uiForEachContinue,
// 	uiForEachStop,
// };
// _UI_ENUM(uiForEach) {
pub type C.uiForEach = u32

pub struct C.uiControl {
	Signature     u32
	OSSignature   u32
	TypeSignature u32
	Destroy       fn (&C.uiControl)
	Handle        fn (&C.uiControl) C.uintptr_t
	Parent        fn (&C.uiControl) &C.uiControl
	SetParent     fn (&C.uiControl, &C.uiControl)
	Toplevel      fn (&C.uiControl) int
	Visible       fn (&C.uiControl) int
	Show          fn (&C.uiControl)
	Hide          fn (&C.uiControl)
	Enabled       fn (&C.uiControl) int
	Enable        fn (&C.uiControl)
	Disable       fn (&C.uiControl)
}

// WORKAROUNDS
@[typedef]
pub type C.uiWindow = int
@[typedef]
pub type C.uiBox = int

@[typedef]
pub struct C.uiInitOptions {
	Size C.size_t
}

pub struct C.attr {
	val &C.uiAttribute
	start C.size_t
	end C.size_t
	prev &C.attr
	next &C.attr
}

pub struct C.uiprivAttrList {
	first &C.attr
	last &C.attr
}

pub struct C.uiAttributedString {
    s         string
    len       usize
    attrs     &C.uiprivAttrList
    u16       &u16
    u16len    usize
    u8tou16   &usize
    u16tou8   &usize
    graphemes &C.uiPrivGraphemes
}

pub struct C.feature {
	a char
	b char
	c char
	d char
	value C.uint32_t
};

pub struct C.uiOpenTypeFeatures {
	data &C.feature
	len C.size_t
	cap C.size_t
};

// enum C.uiAttributeType {
type C.uiAttributeType = int
pub const uiAttributeTypeFamily = 0
pub const uiAttributeTypeSize = 1
pub const uiAttributeTypeWeight = 2
pub const uiAttributeTypeItalic = 3
pub const uiAttributeTypeStretch = 4
pub const uiAttributeTypeColor = 5
pub const uiAttributeTypeBackground = 6
pub const uiAttributeTypeUnderline = 7
pub const uiAttributeTypeUnderlineColor = 8
pub const uiAttributeTypeFeatures = 9

pub type C.uiTextWeight = int
pub const uiTextWeightMinimum = 0
pub const uiTextWeightThin = 100
pub const uiTextWeightUltraLight = 200
pub const uiTextWeightLight = 300
pub const uiTextWeightBook = 350
pub const uiTextWeightNormal = 400
pub const uiTextWeightMedium = 500
pub const uiTextWeightSemiBold = 600
pub const uiTextWeightBold = 700
pub const uiTextWeightUltraBold = 800
pub const uiTextWeightHeavy = 900
pub const uiTextWeightUltraHeavy = 950
pub const uiTextWeightMaximum = 1000

pub type C.uiTextItalic = int
pub const uiTextItalicNormal = 0
pub const uiTextItalicOblique = 1
pub const uiTextItalicItalic = 2

pub type C.uiTextStretch = int
pub const uiTextStretchUltraCondensed = 0
pub const uiTextStretchExtraCondensed = 1
pub const uiTextStretchCondensed = 2
pub const uiTextStretchSemiCondensed = 3
pub const uiTextStretchNormal = 4
pub const uiTextStretchSemiExpanded = 5
pub const uiTextStretchExpanded = 6
pub const uiTextStretchExtraExpanded = 7
pub const uiTextStretchUltraExpanded = 8

pub struct C.uiUnderlineColor {
    r f64
    g f64
    b f64
    a f64
}

pub type C.uiUnderline = int
pub const uiUnderlineNone = 0
pub const uiUnderlineSingle = 1
pub const uiUnderlineDouble = 2
pub const uiUnderlineSuggestion = 3

pub struct C.uiColor {
    r f64
    g f64
    b f64
    a f64
    underline_color C.uiUnderlineColor
}

pub type C.uiAttributeValue = string | f64 | C.uiTextWeight | C.uiTextItalic | C.uiTextStretch | C.uiColor | C.uiUnderline | C.uiOpenTypeFeatures

pub struct C.uiAttribute { 
	OwnedByUser int
	Refcount usize
	Type C.uiAttributeType
	Value C.uiAttributeValue
}

@[typedef]
pub struct C.uiAreaHandler {
    Draw         voidptr // void (*Draw)(uiAreaHandler *, uiArea *, uiAreaDrawParams *)
    MouseEvent   voidptr // void (*MouseEvent)(uiAreaHandler *, uiArea *, uiAreaMouseEvent *)
    MouseCrossed voidptr // void (*MouseCrossed)(uiAreaHandler *, uiArea *, int)
    DragBroken   voidptr // void (*DragBroken)(uiAreaHandler *, uiArea *)
    KeyEvent     voidptr // int (*KeyEvent)(uiAreaHandler *, uiArea *, uiAreaKeyEvent *)
}


// empty enum
const ui_for_each_continue = 0
const ui_for_each_stop = 1

pub struct C.uiInitOptions {
	size usize
}

pub fn C.asUiControl(v voidptr) &C.uiControl

pub fn uiControl(v voidptr) &C.uiControl {
	return C.asUiControl(v)
}

// pub fn C.createUiAreaHandler() C.uiAreaHandler

// pub fn createUiAreaHandler() C.uiAreaHandler {
// 	return C.createUiAreaHandler()
// }


pub fn C.uiInit(options &C.uiInitOptions) &i8

pub fn ui_init(options &C.uiInitOptions) &i8 {
	return C.uiInit(options)
}

pub fn C.uiUninit()

pub fn ui_uninit() {
	C.uiUninit()
}

pub fn C.uiFreeInitError(err &i8)

pub fn ui_free_init_error(err &i8) {
	C.uiFreeInitError(err)
}

pub fn C.uiMain()

pub fn ui_main() {
	C.uiMain()
}

pub fn C.uiMainSteps()

pub fn ui_main_steps() {
	C.uiMainSteps()
}

pub fn C.uiMainStep(wait int) int

pub fn ui_main_step(wait int) int {
	return C.uiMainStep(wait)
}

pub fn C.uiQuit()

pub fn ui_quit() {
	C.uiQuit()
}

pub fn C.uiQueueMain(f fn (voidptr), data voidptr)

pub fn ui_queue_main(f fn (voidptr), data voidptr) {
	C.uiQueueMain(f, data)
}

// TODO standardize the looping behavior return type, either with some enum or something, and the test expressions throughout the code
// TODO figure out what to do about looping and the exact point that the timer is rescheduled so we can document it; see https://github.com/andlabs/libui/pull/277
// TODO (also in the above link) document that this cannot be called from any thread, unlike uiQueueMain()
// TODO document that the minimum exact timing, either accuracy (timer burst, etc.) or granularity (15ms on Windows, etc.), is OS-defined
// TODO also figure out how long until the initial tick is registered on all platforms to document
// TODO also add a comment about how useful this could be in bindings, depending on the language being bound to
pub fn C.uiTimer(milliseconds int, f fn (voidptr) int, data voidptr)

pub fn ui_timer(milliseconds int, f fn (voidptr) int, data voidptr) {
	C.uiTimer(milliseconds, f, data)
}

pub fn C.uiOnShouldQuit(f fn (voidptr) int, data voidptr)

pub fn ui_on_should_quit(f fn (voidptr) int, data voidptr) {
	C.uiOnShouldQuit(f, data)
}

pub fn C.uiFreeText(text &i8)

pub fn ui_free_text(text &i8) {
	C.uiFreeText(text)
}

// TOOD add argument names to all arguments
pub fn C.uiControlDestroy(arg0 &C.uiControl)

pub fn ui_control_destroy(arg0 &C.uiControl) {
	C.uiControlDestroy(arg0)
}

pub fn C.uiControlHandle(arg0 &C.uiControl) C.uintptr_t

pub fn ui_control_handle(arg0 &C.uiControl) C.uintptr_t {
	return C.uiControlHandle(arg0)
}

pub fn C.uiControlParent(arg0 &C.uiControl) &C.uiControl

pub fn ui_control_parent(arg0 &C.uiControl) &C.uiControl {
	return C.uiControlParent(arg0)
}

pub fn C.uiControlSetParent(arg0 &C.uiControl, arg1 &C.uiControl)

pub fn ui_control_set_parent(arg0 &C.uiControl, arg1 &C.uiControl) {
	C.uiControlSetParent(arg0, arg1)
}

pub fn C.uiControlToplevel(arg0 &C.uiControl) int

pub fn ui_control_toplevel(arg0 &C.uiControl) int {
	return C.uiControlToplevel(arg0)
}

pub fn C.uiControlVisible(arg0 &C.uiControl) int

pub fn ui_control_visible(arg0 &C.uiControl) int {
	return C.uiControlVisible(arg0)
}

pub fn C.uiControlShow(arg0 &C.uiControl)

pub fn ui_control_show(arg0 &C.uiControl) {
	C.uiControlShow(arg0)
}

pub fn C.uiControlHide(arg0 &C.uiControl)

pub fn ui_control_hide(arg0 &C.uiControl) {
	C.uiControlHide(arg0)
}

pub fn C.uiControlEnabled(arg0 &C.uiControl) int

pub fn ui_control_enabled(arg0 &C.uiControl) int {
	return C.uiControlEnabled(arg0)
}

pub fn C.uiControlEnable(arg0 &C.uiControl)

pub fn ui_control_enable(arg0 &C.uiControl) {
	C.uiControlEnable(arg0)
}

pub fn C.uiControlDisable(arg0 &C.uiControl)

pub fn ui_control_disable(arg0 &C.uiControl) {
	C.uiControlDisable(arg0)
}

pub fn C.uiAllocControl(n usize, os_sig u32, typesig u32, typenamestr &i8) &C.uiControl

pub fn ui_alloc_control(n usize, os_sig u32, typesig u32, typenamestr &i8) &C.uiControl {
	return C.uiAllocControl(n, os_sig, typesig, typenamestr)
}

pub fn C.uiFreeControl(arg0 &C.uiControl)

pub fn ui_free_control(arg0 &C.uiControl) {
	C.uiFreeControl(arg0)
}

// TODO make sure all controls have these
pub fn C.uiControlVerifySetParent(arg0 &C.uiControl, arg1 &C.uiControl)

pub fn ui_control_verify_set_parent(arg0 &C.uiControl, arg1 &C.uiControl) {
	C.uiControlVerifySetParent(arg0, arg1)
}

pub fn C.uiControlEnabledToUser(arg0 &C.uiControl) int

pub fn ui_control_enabled_to_user(arg0 &C.uiControl) int {
	return C.uiControlEnabledToUser(arg0)
}

pub fn C.uiUserBugCannotSetParentOnToplevel(type_ &i8)

pub fn ui_user_bug_cannot_set_parent_on_toplevel(type_ &i8) {
	C.uiUserBugCannotSetParentOnToplevel(type_)
}

pub fn C.uiWindowTitle(w &C.uiWindow) &i8

pub fn ui_window_title(w &C.uiWindow) &i8 {
	return C.uiWindowTitle(w)
}

pub fn C.uiWindowSetTitle(w &C.uiWindow, title &i8)

pub fn ui_window_set_title(w &C.uiWindow, title &i8) {
	C.uiWindowSetTitle(w, title)
}

pub fn C.uiWindowContentSize(w &C.uiWindow, width &int, height &int)

pub fn ui_window_content_size(w &C.uiWindow, width &int, height &int) {
	C.uiWindowContentSize(w, width, height)
}

pub fn C.uiWindowSetContentSize(w &C.uiWindow, width int, height int)

pub fn ui_window_set_content_size(w &C.uiWindow, width int, height int) {
	C.uiWindowSetContentSize(w, width, height)
}

pub fn C.uiWindowFullscreen(w &C.uiWindow) int

pub fn ui_window_fullscreen(w &C.uiWindow) int {
	return C.uiWindowFullscreen(w)
}

pub fn C.uiWindowSetFullscreen(w &C.uiWindow, fullscreen int)

pub fn ui_window_set_fullscreen(w &C.uiWindow, fullscreen int) {
	C.uiWindowSetFullscreen(w, fullscreen)
}

pub fn C.uiWindowOnContentSizeChanged(w &C.uiWindow, f fn (&C.uiWindow, voidptr), data voidptr)

pub fn ui_window_on_content_size_changed(w &C.uiWindow, f fn (&C.uiWindow, voidptr), data voidptr) {
	C.uiWindowOnContentSizeChanged(w, f, data)
}

pub fn C.uiWindowOnClosing(w &C.uiWindow, f fn (&C.uiWindow, voidptr) int, data voidptr)

pub fn ui_window_on_closing(w &C.uiWindow, f fn (&C.uiWindow, voidptr) int, data voidptr) {
	C.uiWindowOnClosing(w, f, data)
}

pub fn C.uiWindowBorderless(w &C.uiWindow) int

pub fn ui_window_borderless(w &C.uiWindow) int {
	return C.uiWindowBorderless(w)
}

pub fn C.uiWindowSetBorderless(w &C.uiWindow, borderless int)

pub fn ui_window_set_borderless(w &C.uiWindow, borderless int) {
	C.uiWindowSetBorderless(w, borderless)
}

pub fn C.uiWindowSetChild(w &C.uiWindow, child &C.uiControl)

pub fn ui_window_set_child(w &C.uiWindow, child &C.uiControl) {
	C.uiWindowSetChild(w, child)
}

pub fn C.uiWindowMargined(w &C.uiWindow) int

pub fn ui_window_margined(w &C.uiWindow) int {
	return C.uiWindowMargined(w)
}

pub fn C.uiWindowSetMargined(w &C.uiWindow, margined int)

pub fn ui_window_set_margined(w &C.uiWindow, margined int) {
	C.uiWindowSetMargined(w, margined)
}

pub fn C.uiNewWindow(title &i8, width int, height int, has_menubar int) &C.uiWindow

pub fn ui_new_window(title &i8, width int, height int, has_menubar int) &C.uiWindow {
	return C.uiNewWindow(title, width, height, has_menubar)
}

pub fn C.uiButtonText(b &C.uiButton) &i8

pub fn ui_button_text(b &C.uiButton) &i8 {
	return C.uiButtonText(b)
}

pub fn C.uiButtonSetText(b &C.uiButton, text &i8)

pub fn ui_button_set_text(b &C.uiButton, text &i8) {
	C.uiButtonSetText(b, text)
}

pub fn C.uiButtonOnClicked(b &C.uiButton, f fn (&C.uiButton, voidptr), data voidptr)

pub fn ui_button_on_clicked(b &C.uiButton, f fn (&C.uiButton, voidptr), data voidptr) {
	C.uiButtonOnClicked(b, f, data)
}

pub fn C.uiNewButton(text &i8) &C.uiButton

pub fn ui_new_button(text &i8) &C.uiButton {
	return C.uiNewButton(text)
}

pub fn C.uiBoxAppend(b &C.uiBox, child &C.uiControl, stretchy int)

pub fn ui_box_append(b &C.uiBox, child &C.uiControl, stretchy int) {
	C.uiBoxAppend(b, child, stretchy)
}

pub fn C.uiBoxDelete(b &C.uiBox, index int)

pub fn ui_box_delete(b &C.uiBox, index int) {
	C.uiBoxDelete(b, index)
}

pub fn C.uiBoxPadded(b &C.uiBox) int

pub fn ui_box_padded(b &C.uiBox) int {
	return C.uiBoxPadded(b)
}

pub fn C.uiBoxSetPadded(b &C.uiBox, padded int)

pub fn ui_box_set_padded(b &C.uiBox, padded int) {
	C.uiBoxSetPadded(b, padded)
}

pub fn C.uiNewHorizontalBox() &C.uiBox

pub fn ui_new_horizontal_box() &C.uiBox {
	return C.uiNewHorizontalBox()
}

pub fn C.uiNewVerticalBox() &C.uiBox

pub fn ui_new_vertical_box() &C.uiBox {
	return C.uiNewVerticalBox()
}

pub fn C.uiCheckboxText(c &C.uiCheckbox) &i8

pub fn ui_checkbox_text(c &C.uiCheckbox) &i8 {
	return C.uiCheckboxText(c)
}

pub fn C.uiCheckboxSetText(c &C.uiCheckbox, text &i8)

pub fn ui_checkbox_set_text(c &C.uiCheckbox, text &i8) {
	C.uiCheckboxSetText(c, text)
}

pub fn C.uiCheckboxOnToggled(c &C.uiCheckbox, f fn (&C.uiCheckbox, voidptr), data voidptr)

pub fn ui_checkbox_on_toggled(c &C.uiCheckbox, f fn (&C.uiCheckbox, voidptr), data voidptr) {
	C.uiCheckboxOnToggled(c, f, data)
}

pub fn C.uiCheckboxChecked(c &C.uiCheckbox) int

pub fn ui_checkbox_checked(c &C.uiCheckbox) int {
	return C.uiCheckboxChecked(c)
}

pub fn C.uiCheckboxSetChecked(c &C.uiCheckbox, checked int)

pub fn ui_checkbox_set_checked(c &C.uiCheckbox, checked int) {
	C.uiCheckboxSetChecked(c, checked)
}

pub fn C.uiNewCheckbox(text &i8) &C.uiCheckbox

pub fn ui_new_checkbox(text &i8) &C.uiCheckbox {
	return C.uiNewCheckbox(text)
}

pub fn C.uiEntryText(e &C.uiEntry) &i8

pub fn ui_entry_text(e &C.uiEntry) &i8 {
	return C.uiEntryText(e)
}

pub fn C.uiEntrySetText(e &C.uiEntry, text &i8)

pub fn ui_entry_set_text(e &C.uiEntry, text &i8) {
	C.uiEntrySetText(e, text)
}

pub fn C.uiEntryOnChanged(e &C.uiEntry, f fn (&C.uiEntry, voidptr), data voidptr)

pub fn ui_entry_on_changed(e &C.uiEntry, f fn (&C.uiEntry, voidptr), data voidptr) {
	C.uiEntryOnChanged(e, f, data)
}

pub fn C.uiEntryReadOnly(e &C.uiEntry) int

pub fn ui_entry_read_only(e &C.uiEntry) int {
	return C.uiEntryReadOnly(e)
}

pub fn C.uiEntrySetReadOnly(e &C.uiEntry, readonly int)

pub fn ui_entry_set_read_only(e &C.uiEntry, readonly int) {
	C.uiEntrySetReadOnly(e, readonly)
}

pub fn C.uiNewEntry() &C.uiEntry

pub fn ui_new_entry() &C.uiEntry {
	return C.uiNewEntry()
}

pub fn C.uiNewPasswordEntry() &C.uiEntry

pub fn ui_new_password_entry() &C.uiEntry {
	return C.uiNewPasswordEntry()
}

pub fn C.uiNewSearchEntry() &C.uiEntry

pub fn ui_new_search_entry() &C.uiEntry {
	return C.uiNewSearchEntry()
}

pub fn C.uiLabelText(l &C.uiLabel) &i8

pub fn ui_label_text(l &C.uiLabel) &i8 {
	return C.uiLabelText(l)
}

pub fn C.uiLabelSetText(l &C.uiLabel, text &i8)

pub fn ui_label_set_text(l &C.uiLabel, text &i8) {
	C.uiLabelSetText(l, text)
}

pub fn C.uiNewLabel(text &i8) &C.uiLabel

pub fn ui_new_label(text &i8) &C.uiLabel {
	return C.uiNewLabel(text)
}

pub fn C.uiTabAppend(t &C.uiTab, name &i8, c &C.uiControl)

pub fn ui_tab_append(t &C.uiTab, name &i8, c &C.uiControl) {
	C.uiTabAppend(t, name, c)
}

pub fn C.uiTabInsertAt(t &C.uiTab, name &i8, before int, c &C.uiControl)

pub fn ui_tab_insert_at(t &C.uiTab, name &i8, before int, c &C.uiControl) {
	C.uiTabInsertAt(t, name, before, c)
}

pub fn C.uiTabDelete(t &C.uiTab, index int)

pub fn ui_tab_delete(t &C.uiTab, index int) {
	C.uiTabDelete(t, index)
}

pub fn C.uiTabNumPages(t &C.uiTab) int

pub fn ui_tab_num_pages(t &C.uiTab) int {
	return C.uiTabNumPages(t)
}

pub fn C.uiTabMargined(t &C.uiTab, page int) int

pub fn ui_tab_margined(t &C.uiTab, page int) int {
	return C.uiTabMargined(t, page)
}

pub fn C.uiTabSetMargined(t &C.uiTab, page int, margined int)

pub fn ui_tab_set_margined(t &C.uiTab, page int, margined int) {
	C.uiTabSetMargined(t, page, margined)
}

pub fn C.uiNewTab() &C.uiTab

pub fn ui_new_tab() &C.uiTab {
	return C.uiNewTab()
}

pub fn C.uiGroupTitle(g &C.uiGroup) &i8

pub fn ui_group_title(g &C.uiGroup) &i8 {
	return C.uiGroupTitle(g)
}

pub fn C.uiGroupSetTitle(g &C.uiGroup, title &i8)

pub fn ui_group_set_title(g &C.uiGroup, title &i8) {
	C.uiGroupSetTitle(g, title)
}

pub fn C.uiGroupSetChild(g &C.uiGroup, c &C.uiControl)

pub fn ui_group_set_child(g &C.uiGroup, c &C.uiControl) {
	C.uiGroupSetChild(g, c)
}

pub fn C.uiGroupMargined(g &C.uiGroup) int

pub fn ui_group_margined(g &C.uiGroup) int {
	return C.uiGroupMargined(g)
}

pub fn C.uiGroupSetMargined(g &C.uiGroup, margined int)

pub fn ui_group_set_margined(g &C.uiGroup, margined int) {
	C.uiGroupSetMargined(g, margined)
}

pub fn C.uiNewGroup(title &i8) &C.uiGroup

pub fn ui_new_group(title &i8) &C.uiGroup {
	return C.uiNewGroup(title)
}

// spinbox/slider rules:
// setting value outside of range will automatically clamp
// initial value is minimum
// complaint if min >= max?
pub fn C.uiSpinboxValue(s &C.uiSpinbox) int

pub fn ui_spinbox_value(s &C.uiSpinbox) int {
	return C.uiSpinboxValue(s)
}

pub fn C.uiSpinboxSetValue(s &C.uiSpinbox, value int)

pub fn ui_spinbox_set_value(s &C.uiSpinbox, value int) {
	C.uiSpinboxSetValue(s, value)
}

pub fn C.uiSpinboxOnChanged(s &C.uiSpinbox, f fn (&C.uiSpinbox, voidptr), data voidptr)

pub fn ui_spinbox_on_changed(s &C.uiSpinbox, f fn (&C.uiSpinbox, voidptr), data voidptr) {
	C.uiSpinboxOnChanged(s, f, data)
}

pub fn C.uiNewSpinbox(min int, max int) &C.uiSpinbox

pub fn ui_new_spinbox(min int, max int) &C.uiSpinbox {
	return C.uiNewSpinbox(min, max)
}

pub fn C.uiSliderValue(s &C.uiSlider) int

pub fn ui_slider_value(s &C.uiSlider) int {
	return C.uiSliderValue(s)
}

pub fn C.uiSliderSetValue(s &C.uiSlider, value int)

pub fn ui_slider_set_value(s &C.uiSlider, value int) {
	C.uiSliderSetValue(s, value)
}

pub fn C.uiSliderOnChanged(s &C.uiSlider, f fn (&C.uiSlider, voidptr), data voidptr)

pub fn ui_slider_on_changed(s &C.uiSlider, f fn (&C.uiSlider, voidptr), data voidptr) {
	C.uiSliderOnChanged(s, f, data)
}

pub fn C.uiNewSlider(min int, max int) &C.uiSlider

pub fn ui_new_slider(min int, max int) &C.uiSlider {
	return C.uiNewSlider(min, max)
}

pub fn C.uiProgressBarValue(p C.uiProgressBar) int

pub fn ui_progress_bar_value(p C.uiProgressBar) int {
	return C.uiProgressBarValue(p)
}

pub fn C.uiProgressBarSetValue(p C.uiProgressBar, n int)

pub fn ui_progress_bar_set_value(p C.uiProgressBar, n int) {
	C.uiProgressBarSetValue(p, n)
}

pub fn C.uiNewProgressBar() &C.uiProgressBar

pub fn ui_new_progress_bar() &C.uiProgressBar {
	return C.uiNewProgressBar()
}

pub fn C.uiNewHorizontalSeparator() &C.uiSeparator

pub fn ui_new_horizontal_separator() &C.uiSeparator {
	return C.uiNewHorizontalSeparator()
}

pub fn C.uiNewVerticalSeparator() &C.uiSeparator

pub fn ui_new_vertical_separator() &C.uiSeparator {
	return C.uiNewVerticalSeparator()
}

pub fn C.uiComboboxAppend(c &C.uiCombobox, text &i8)

pub fn ui_combobox_append(c &C.uiCombobox, text &i8) {
	C.uiComboboxAppend(c, text)
}

pub fn C.uiComboboxSelected(c &C.uiCombobox) int

pub fn ui_combobox_selected(c &C.uiCombobox) int {
	return C.uiComboboxSelected(c)
}

pub fn C.uiComboboxSetSelected(c &C.uiCombobox, n int)

pub fn ui_combobox_set_selected(c &C.uiCombobox, n int) {
	C.uiComboboxSetSelected(c, n)
}

pub fn C.uiComboboxOnSelected(c &C.uiCombobox, f fn (&C.uiCombobox, voidptr), data voidptr)

pub fn ui_combobox_on_selected(c &C.uiCombobox, f fn (&C.uiCombobox, voidptr), data voidptr) {
	C.uiComboboxOnSelected(c, f, data)
}

pub fn C.uiNewCombobox() &C.uiCombobox

pub fn ui_new_combobox() &C.uiCombobox {
	return C.uiNewCombobox()
}

pub fn C.uiEditableComboboxAppend(c &C.uiEditableCombobox, text &i8)

pub fn ui_editable_combobox_append(c &C.uiEditableCombobox, text &i8) {
	C.uiEditableComboboxAppend(c, text)
}

pub fn C.uiEditableComboboxText(c &C.uiEditableCombobox) &i8

pub fn ui_editable_combobox_text(c &C.uiEditableCombobox) &i8 {
	return C.uiEditableComboboxText(c)
}

pub fn C.uiEditableComboboxSetText(c &C.uiEditableCombobox, text &i8)

pub fn ui_editable_combobox_set_text(c &C.uiEditableCombobox, text &i8) {
	C.uiEditableComboboxSetText(c, text)
}

// TODO what do we call a function that sets the currently selected item and fills the text field with it? editable comboboxes have no consistent concept of selected item
pub fn C.uiEditableComboboxOnChanged(c &C.uiEditableCombobox, f fn (&C.uiEditableCombobox, voidptr), data voidptr)

pub fn ui_editable_combobox_on_changed(c &C.uiEditableCombobox, f fn (&C.uiEditableCombobox, voidptr), data voidptr) {
	C.uiEditableComboboxOnChanged(c, f, data)
}

pub fn C.uiNewEditableCombobox() &C.uiEditableCombobox

pub fn ui_new_editable_combobox() &C.uiEditableCombobox {
	return C.uiNewEditableCombobox()
}

pub fn C.uiRadioButtonsAppend(r &C.uiRadioButtons, text &i8)

pub fn ui_radio_buttons_append(r &C.uiRadioButtons, text &i8) {
	C.uiRadioButtonsAppend(r, text)
}

pub fn C.uiRadioButtonsSelected(r &C.uiRadioButtons) int

pub fn ui_radio_buttons_selected(r &C.uiRadioButtons) int {
	return C.uiRadioButtonsSelected(r)
}

pub fn C.uiRadioButtonsSetSelected(r &C.uiRadioButtons, n int)

pub fn ui_radio_buttons_set_selected(r &C.uiRadioButtons, n int) {
	C.uiRadioButtonsSetSelected(r, n)
}

pub fn C.uiRadioButtonsOnSelected(r &C.uiRadioButtons, f fn (&C.uiRadioButtons, voidptr), data voidptr)

pub fn ui_radio_buttons_on_selected(r &C.uiRadioButtons, f fn (&C.uiRadioButtons, voidptr), data voidptr) {
	C.uiRadioButtonsOnSelected(r, f, data)
}

pub fn C.uiNewRadioButtons() &C.uiRadioButtons

pub fn ui_new_radio_buttons() &C.uiRadioButtons {
	return C.uiNewRadioButtons()
}

// TODO document that tm_wday and tm_yday are undefined, and tm_isdst should be -1
// TODO document that for both sides
// TODO document time zone conversions or lack thereof
// TODO for Time: define what values are returned when a part is missing
pub fn C.uiDateTimePickerTime(d &C.uiDateTimePicker, time &C.tm)

pub fn ui_date_time_picker_time(d &C.uiDateTimePicker, time &C.tm) {
	C.uiDateTimePickerTime(d, time)
}

pub fn C.uiDateTimePickerSetTime(d &C.uiDateTimePicker, time &C.tm)

pub fn ui_date_time_picker_set_time(d &C.uiDateTimePicker, time &C.tm) {
	C.uiDateTimePickerSetTime(d, time)
}

pub fn C.uiDateTimePickerOnChanged(d &C.uiDateTimePicker, f fn (&C.uiDateTimePicker, voidptr), data voidptr)

pub fn ui_date_time_picker_on_changed(d &C.uiDateTimePicker, f fn (&C.uiDateTimePicker, voidptr), data voidptr) {
	C.uiDateTimePickerOnChanged(d, f, data)
}

pub fn C.uiNewDateTimePicker() &C.uiDateTimePicker

pub fn ui_new_date_time_picker() &C.uiDateTimePicker {
	return C.uiNewDateTimePicker()
}

pub fn C.uiNewDatePicker() &C.uiDateTimePicker

pub fn ui_new_date_picker() &C.uiDateTimePicker {
	return C.uiNewDatePicker()
}

pub fn C.uiNewTimePicker() &C.uiDateTimePicker

pub fn ui_new_time_picker() &C.uiDateTimePicker {
	return C.uiNewTimePicker()
}

// TODO provide a facility for entering tab stops?
pub fn C.uiMultilineEntryText(e &C.uiMultilineEntry) &i8

pub fn ui_multiline_entry_text(e &C.uiMultilineEntry) &i8 {
	return C.uiMultilineEntryText(e)
}

pub fn C.uiMultilineEntrySetText(e &C.uiMultilineEntry, text &i8)

pub fn ui_multiline_entry_set_text(e &C.uiMultilineEntry, text &i8) {
	C.uiMultilineEntrySetText(e, text)
}

pub fn C.uiMultilineEntryAppend(e &C.uiMultilineEntry, text &i8)

pub fn ui_multiline_entry_append(e &C.uiMultilineEntry, text &i8) {
	C.uiMultilineEntryAppend(e, text)
}

pub fn C.uiMultilineEntryOnChanged(e &C.uiMultilineEntry, f fn (&C.uiMultilineEntry, voidptr), data voidptr)

pub fn ui_multiline_entry_on_changed(e &C.uiMultilineEntry, f fn (&C.uiMultilineEntry, voidptr), data voidptr) {
	C.uiMultilineEntryOnChanged(e, f, data)
}

pub fn C.uiMultilineEntryReadOnly(e &C.uiMultilineEntry) int

pub fn ui_multiline_entry_read_only(e &C.uiMultilineEntry) int {
	return C.uiMultilineEntryReadOnly(e)
}

pub fn C.uiMultilineEntrySetReadOnly(e &C.uiMultilineEntry, readonly int)

pub fn ui_multiline_entry_set_read_only(e &C.uiMultilineEntry, readonly int) {
	C.uiMultilineEntrySetReadOnly(e, readonly)
}

pub fn C.uiNewMultilineEntry() &C.uiMultilineEntry

pub fn ui_new_multiline_entry() &C.uiMultilineEntry {
	return C.uiNewMultilineEntry()
}

pub fn C.uiNewNonWrappingMultilineEntry() &C.uiMultilineEntry

pub fn ui_new_non_wrapping_multiline_entry() &C.uiMultilineEntry {
	return C.uiNewNonWrappingMultilineEntry()
}

pub fn C.uiMenuItemEnable(m &C.uiMenuItem)

pub fn ui_menu_item_enable(m &C.uiMenuItem) {
	C.uiMenuItemEnable(m)
}

pub fn C.uiMenuItemDisable(m &C.uiMenuItem)

pub fn ui_menu_item_disable(m &C.uiMenuItem) {
	C.uiMenuItemDisable(m)
}

pub fn C.uiMenuItemOnClicked(m &C.uiMenuItem, f fn (&C.uiMenuItem, &C.uiWindow, voidptr), data voidptr)

pub fn ui_menu_item_on_clicked(m &C.uiMenuItem, f fn (&C.uiMenuItem, &C.uiWindow, voidptr), data voidptr) {
	C.uiMenuItemOnClicked(m, f, data)
}

pub fn C.uiMenuItemChecked(m &C.uiMenuItem) int

pub fn ui_menu_item_checked(m &C.uiMenuItem) int {
	return C.uiMenuItemChecked(m)
}

pub fn C.uiMenuItemSetChecked(m &C.uiMenuItem, checked int)

pub fn ui_menu_item_set_checked(m &C.uiMenuItem, checked int) {
	C.uiMenuItemSetChecked(m, checked)
}

pub fn C.uiMenuAppendItem(m &C.uiMenu, name &i8) &C.uiMenuItem

pub fn ui_menu_append_item(m &C.uiMenu, name &i8) &C.uiMenuItem {
	return C.uiMenuAppendItem(m, name)
}

pub fn C.uiMenuAppendCheckItem(m &C.uiMenu, name &i8) &C.uiMenuItem

pub fn ui_menu_append_check_item(m &C.uiMenu, name &i8) &C.uiMenuItem {
	return C.uiMenuAppendCheckItem(m, name)
}

pub fn C.uiMenuAppendQuitItem(m &C.uiMenu) &C.uiMenuItem

pub fn ui_menu_append_quit_item(m &C.uiMenu) &C.uiMenuItem {
	return C.uiMenuAppendQuitItem(m)
}

pub fn C.uiMenuAppendPreferencesItem(m &C.uiMenu) &C.uiMenuItem

pub fn ui_menu_append_preferences_item(m &C.uiMenu) &C.uiMenuItem {
	return C.uiMenuAppendPreferencesItem(m)
}

pub fn C.uiMenuAppendAboutItem(m &C.uiMenu) &C.uiMenuItem

pub fn ui_menu_append_about_item(m &C.uiMenu) &C.uiMenuItem {
	return C.uiMenuAppendAboutItem(m)
}

pub fn C.uiMenuAppendSeparator(m &C.uiMenu)

pub fn ui_menu_append_separator(m &C.uiMenu) {
	C.uiMenuAppendSeparator(m)
}

pub fn C.uiNewMenu(name &i8) &C.uiMenu

pub fn ui_new_menu(name &i8) &C.uiMenu {
	return C.uiNewMenu(name)
}

pub fn C.uiOpenFile(parent &C.uiWindow) &i8

pub fn ui_open_file(parent &C.uiWindow) &i8 {
	return C.uiOpenFile(parent)
}

pub fn C.uiSaveFile(parent &C.uiWindow) &i8

pub fn ui_save_file(parent &C.uiWindow) &i8 {
	return C.uiSaveFile(parent)
}

pub fn C.uiMsgBox(parent &C.uiWindow, title &i8, description &i8)

pub fn ui_msg_box(parent &C.uiWindow, title &i8, description &i8) {
	C.uiMsgBox(parent, title, description)
}

pub fn C.uiMsgBoxError(parent &C.uiWindow, title &i8, description &i8)

pub fn ui_msg_box_error(parent &C.uiWindow, title &i8, description &i8) {
	C.uiMsgBoxError(parent, title, description)
}

// pub struct C.uiWindowResizeEdge {
// 	draw fn (C.uiAreaHandler, C.uiArea, C.uiAreaDrawParams)
// 	// TODO document that resizes cause a full redraw for non-scrolling areas; implementation-defined for scrolling areas
// 	mouseEvent fn (C.uiAreaHandler, C.uiArea, C.uiAreaMouseEvent)
// 	// TODO document that on first show if the mouse is already in the uiArea then one gets sent with left=0
// 	// TODO what about when the area is hidden and then shown again?
// 	mouseCrossed fn (C.uiAreaHandler, C.uiArea, int)
// 	dragBroken   fn (C.uiAreaHandler, C.uiArea)
// 	keyEvent     fn (C.uiAreaHandler, C.uiArea, C.uiAreaKeyEvent) int
// }
// @[typedef]
// pub enum C.uiWindowResizeEdge {
// 	ui_window_resize_edge_left,
// 	ui_window_resize_edge_top,
// 	ui_window_resize_edge_right,
// 	C.uiWindowResizeEdgeBottom,
// 	C.uiWindowResizeEdgeTopLeft,
// 	C.uiWindowResizeEdgeTopRight,
// 	C.uiWindowResizeEdgeBottomLeft,
// 	C.uiWindowResizeEdgeBottomRight,
// }

pub type C.uiWindowResizeEdge = int

// TODO RTL layouts?
// TODO reconcile edge and corner naming

// empty enum
const ui_window_resize_edge_left = 0
const ui_window_resize_edge_top = 1
const ui_window_resize_edge_right = 2
const ui_window_resize_edge_bottom = 3
const ui_window_resize_edge_top_left = 4
const ui_window_resize_edge_top_right = 5
const ui_window_resize_edge_bottom_left = 6
const ui_window_resize_edge_bottom_right = 7 // TODO have one for keyboard resizes?
// TODO GDK doesn't seem to have any others, including for keyboards...
// TODO way to bring up the system menu instead?

// TODO give a better name
// TODO document the types of width and height
pub fn C.uiAreaSetSize(a &C.uiArea, width int, height int)

pub fn ui_area_set_size(a &C.uiArea, width int, height int) {
	C.uiAreaSetSize(a, width, height)
}

// TODO uiAreaQueueRedraw()
pub fn C.uiAreaQueueRedrawAll(a &C.uiArea)

pub fn ui_area_queue_redraw_all(a &C.uiArea) {
	C.uiAreaQueueRedrawAll(a)
}

pub fn C.uiAreaScrollTo(a &C.uiArea, x f64, y f64, width f64, height f64)

pub fn ui_area_scroll_to(a &C.uiArea, x f64, y f64, width f64, height f64) {
	C.uiAreaScrollTo(a, x, y, width, height)
}

// TODO document these can only be called within Mouse() handlers
// TODO should these be allowed on scrolling areas?
// TODO decide which mouse events should be accepted; Down is the only one guaranteed to work right now
// TODO what happens to events after calling this up to and including the next mouse up?
// TODO release capture?
pub fn C.uiAreaBeginUserWindowMove(a &C.uiArea)

pub fn ui_area_begin_user_window_move(a &C.uiArea) {
	C.uiAreaBeginUserWindowMove(a)
}

pub fn C.uiAreaBeginUserWindowResize(a &C.uiArea, edge C.uiWindowResizeEdge)

pub fn ui_area_begin_user_window_resize(a &C.uiArea, edge C.uiWindowResizeEdge) {
	C.uiAreaBeginUserWindowResize(a, edge)
}

pub fn C.uiNewArea(ah &C.uiAreaHandler) &C.uiArea

pub fn ui_new_area(ah &C.uiAreaHandler) &C.uiArea {
	return C.uiNewArea(ah)
}

pub fn C.uiNewScrollingArea(ah &C.uiAreaHandler, width int, height int) &C.uiArea

pub fn ui_new_scrolling_area(ah &C.uiAreaHandler, width int, height int) &C.uiArea {
	return C.uiNewScrollingArea(ah, width, height)
}

pub struct C.uiAreaDrawParams {
	Context C.uiDrawContext
	// TODO document that this is only defined for nonscrolling areas
	AreaWidth  f64
	AreaHeight f64
	ClipX      f64
	ClipY      f64
	ClipWidth  f64
	ClipHeight f64
}

pub type UiDrawBrushType = u32

enum UiDrawLineCap {
	ui_draw_brush_type_solid
	ui_draw_brush_type_linear_gradient
	ui_draw_brush_type_radial_gradient
	ui_draw_brush_type_image
}

enum UiDrawLineJoin {
	ui_draw_line_cap_flat
	ui_draw_line_cap_round
	ui_draw_line_cap_square
}

enum UiDrawFillMode {
	ui_draw_line_join_miter
	ui_draw_line_join_round
	ui_draw_line_join_bevel
}

// this is the default for botoh cairo and Direct2D (in the latter case, from the C++ helper functions)
// Core Graphics doesn't explicitly specify a default, but NSBezierPath allows you to choose one, and this is the initial value
// so we're good to use it too!

// empty enum
const ui_draw_fill_mode_winding = 0
const ui_draw_fill_mode_alternate = 1

pub struct C.uiDrawMatrix {
	m11 f64
	m12 f64
	m21 f64
	m22 f64
	m31 f64
	m32 f64
}

pub struct C.uiDrawBrush {
	type UiDrawBrushType
	// solid brushes
	r f64
	g f64
	b f64
	a f64
	// gradient brushes
	x0 f64
	// linear: start X, radial: start X
	y0 f64
	// linear: start Y, radial: start Y
	x1 f64
	// linear: end X, radial: outer circle center X
	y1 f64
	// linear: end Y, radial: outer circle center Y
	outerRadius f64
	// radial gradients only
	stops    C.uiDrawBrushGradientStop
	numStops usize
	// TODO extend mode
	// cairo: none, repeat, reflect, pad; no individual control
	// Direct2D: repeat, reflect, pad; no individual control
	// Core Graphics: none, pad; before and after individually
	// TODO cairo documentation is inconsistent about pad
	// TODO images
	// TODO transforms
}

pub struct C.uiDrawBrushGradientStop {
	pos f64
	r   f64
	g   f64
	b   f64
	a   f64
}

pub struct C.uiDrawStrokeParams {
	cap  UiDrawLineCap
	join UiDrawLineJoin
	// TODO what if this is 0? on windows there will be a crash with dashing
	thickness  f64
	miterLimit f64
	dashes     &f64
	// TOOD what if this is 1 on Direct2D?
	// TODO what if a dash is 0 on Cairo or Quartz?
	numDashes usize
	dashPhase f64
}

pub fn C.uiDrawNewPath(fill_mode UiDrawFillMode) &C.uiDrawPath

pub fn ui_draw_new_path(fill_mode UiDrawFillMode) &C.uiDrawPath {
	return C.uiDrawNewPath(fill_mode)
}

pub fn C.uiDrawFreePath(p &C.uiDrawPath)

pub fn ui_draw_free_path(p &C.uiDrawPath) {
	C.uiDrawFreePath(p)
}

pub fn C.uiDrawPathNewFigure(p &C.uiDrawPath, x f64, y f64)

pub fn ui_draw_path_new_figure(p &C.uiDrawPath, x f64, y f64) {
	C.uiDrawPathNewFigure(p, x, y)
}

pub fn C.uiDrawPathNewFigureWithArc(p &C.uiDrawPath, x_center f64, y_center f64, radius f64, start_angle f64, sweep f64, negative int)

pub fn ui_draw_path_new_figure_with_arc(p &C.uiDrawPath, x_center f64, y_center f64, radius f64, start_angle f64, sweep f64, negative int) {
	C.uiDrawPathNewFigureWithArc(p, x_center, y_center, radius, start_angle, sweep, negative)
}

pub fn C.uiDrawPathLineTo(p &C.uiDrawPath, x f64, y f64)

pub fn ui_draw_path_line_to(p &C.uiDrawPath, x f64, y f64) {
	C.uiDrawPathLineTo(p, x, y)
}

// notes: angles are both relative to 0 and go counterclockwise
// TODO is the initial line segment on cairo and OS X a proper join?
// TODO what if sweep < 0?
pub fn C.uiDrawPathArcTo(p &C.uiDrawPath, x_center f64, y_center f64, radius f64, start_angle f64, sweep f64, negative int)

pub fn ui_draw_path_arc_to(p &C.uiDrawPath, x_center f64, y_center f64, radius f64, start_angle f64, sweep f64, negative int) {
	C.uiDrawPathArcTo(p, x_center, y_center, radius, start_angle, sweep, negative)
}

pub fn C.uiDrawPathBezierTo(p &C.uiDrawPath, c1x f64, c1y f64, c2x f64, c2y f64, end_x f64, end_y f64)

pub fn ui_draw_path_bezier_to(p &C.uiDrawPath, c1x f64, c1y f64, c2x f64, c2y f64, end_x f64, end_y f64) {
	C.uiDrawPathBezierTo(p, c1x, c1y, c2x, c2y, end_x, end_y)
}

// TODO quadratic bezier
pub fn C.uiDrawPathCloseFigure(p &C.uiDrawPath)

pub fn ui_draw_path_close_figure(p &C.uiDrawPath) {
	C.uiDrawPathCloseFigure(p)
}

// TODO effect of these when a figure is already started
pub fn C.uiDrawPathAddRectangle(p &C.uiDrawPath, x f64, y f64, width f64, height f64)

pub fn ui_draw_path_add_rectangle(p &C.uiDrawPath, x f64, y f64, width f64, height f64) {
	C.uiDrawPathAddRectangle(p, x, y, width, height)
}

pub fn C.uiDrawPathEnd(p &C.uiDrawPath)

pub fn ui_draw_path_end(p &C.uiDrawPath) {
	C.uiDrawPathEnd(p)
}

pub fn C.uiDrawStroke(c &C.uiDrawContext, path &C.uiDrawPath, b &C.uiDrawBrush, p &C.uiDrawStrokeParams)

pub fn ui_draw_stroke(c &C.uiDrawContext, path &C.uiDrawPath, b &C.uiDrawBrush, p &C.uiDrawStrokeParams) {
	C.uiDrawStroke(c, path, b, p)
}

pub fn C.uiDrawFill(c &C.uiDrawContext, path &C.uiDrawPath, b &C.uiDrawBrush)

pub fn ui_draw_fill(c &C.uiDrawContext, path &C.uiDrawPath, b &C.uiDrawBrush) {
	C.uiDrawFill(c, path, b)
}

// TODO primitives:
// - rounded rectangles
// - elliptical arcs
// - quadratic bezier curves
pub fn C.uiDrawMatrixSetIdentity(m &C.uiDrawMatrix)

pub fn ui_draw_matrix_set_identity(m &C.uiDrawMatrix) {
	C.uiDrawMatrixSetIdentity(m)
}

pub fn C.uiDrawMatrixTranslate(m &C.uiDrawMatrix, x f64, y f64)

pub fn ui_draw_matrix_translate(m &C.uiDrawMatrix, x f64, y f64) {
	C.uiDrawMatrixTranslate(m, x, y)
}

pub fn C.uiDrawMatrixScale(m &C.uiDrawMatrix, x_center f64, y_center f64, x f64, y f64)

pub fn ui_draw_matrix_scale(m &C.uiDrawMatrix, x_center f64, y_center f64, x f64, y f64) {
	C.uiDrawMatrixScale(m, x_center, y_center, x, y)
}

pub fn C.uiDrawMatrixRotate(m &C.uiDrawMatrix, x f64, y f64, amount f64)

pub fn ui_draw_matrix_rotate(m &C.uiDrawMatrix, x f64, y f64, amount f64) {
	C.uiDrawMatrixRotate(m, x, y, amount)
}

pub fn C.uiDrawMatrixSkew(m &C.uiDrawMatrix, x f64, y f64, xamount f64, yamount f64)

pub fn ui_draw_matrix_skew(m &C.uiDrawMatrix, x f64, y f64, xamount f64, yamount f64) {
	C.uiDrawMatrixSkew(m, x, y, xamount, yamount)
}

pub fn C.uiDrawMatrixMultiply(dest &C.uiDrawMatrix, src &C.uiDrawMatrix)

pub fn ui_draw_matrix_multiply(dest &C.uiDrawMatrix, src &C.uiDrawMatrix) {
	C.uiDrawMatrixMultiply(dest, src)
}

pub fn C.uiDrawMatrixInvertible(m &C.uiDrawMatrix) int

pub fn ui_draw_matrix_invertible(m &C.uiDrawMatrix) int {
	return C.uiDrawMatrixInvertible(m)
}

pub fn C.uiDrawMatrixInvert(m &C.uiDrawMatrix) int

pub fn ui_draw_matrix_invert(m &C.uiDrawMatrix) int {
	return C.uiDrawMatrixInvert(m)
}

pub fn C.uiDrawMatrixTransformPoint(m &C.uiDrawMatrix, x &f64, y &f64)

pub fn ui_draw_matrix_transform_point(m &C.uiDrawMatrix, x &f64, y &f64) {
	C.uiDrawMatrixTransformPoint(m, x, y)
}

pub fn C.uiDrawMatrixTransformSize(m &C.uiDrawMatrix, x &f64, y &f64)

pub fn ui_draw_matrix_transform_size(m &C.uiDrawMatrix, x &f64, y &f64) {
	C.uiDrawMatrixTransformSize(m, x, y)
}

pub fn C.uiDrawTransform(c &C.uiDrawContext, m &C.uiDrawMatrix)

pub fn ui_draw_transform(c &C.uiDrawContext, m &C.uiDrawMatrix) {
	C.uiDrawTransform(c, m)
}

// TODO add a uiDrawPathStrokeToFill() or something like that
pub fn C.uiDrawClip(c &C.uiDrawContext, path &C.uiDrawPath)

pub fn ui_draw_clip(c &C.uiDrawContext, path &C.uiDrawPath) {
	C.uiDrawClip(c, path)
}

pub fn C.uiDrawSave(c &C.uiDrawContext)

pub fn ui_draw_save(c &C.uiDrawContext) {
	C.uiDrawSave(c)
}

pub fn C.uiDrawRestore(c &C.uiDrawContext)

pub fn ui_draw_restore(c &C.uiDrawContext) {
	C.uiDrawRestore(c)
}

// uiAttribute stores information about an attribute in a
// uiAttributedString.
//
// You do not create uiAttributes directly; instead, you create a
// uiAttribute of a given type using the specialized constructor
// functions. For every Unicode codepoint in the uiAttributedString,
// at most one value of each attribute type can be applied.
//
// uiAttributes are immutable and the uiAttributedString takes
// ownership of the uiAttribute object once assigned, copying its
// contents as necessary.
// @role uiAttribute destructor
// uiFreeAttribute() frees a uiAttribute. You generally do not need to
// call this yourself, as uiAttributedString does this for you. In fact,
// it is an error to call this function on a uiAttribute that has been
// given to a uiAttributedString. You can call this, however, if you
// created a uiAttribute that you aren't going to use later.
pub fn C.uiFreeAttribute(a &C.uiAttribute)

pub fn ui_free_attribute(a &C.uiAttribute) {
	C.uiFreeAttribute(a)
}

// uiAttributeType holds the possible uiAttribute types that may be
// returned by uiAttributeGetType(). Refer to the documentation for
// each type's constructor function for details on each type.
// type C.uiAttributeType = u32

// empty enum
// const ui_attribute_type_family = 0
// const ui_attribute_type_size = 1
// const ui_attribute_type_weight = 2
// const ui_attribute_type_italic = 3
// const ui_attribute_type_stretch = 4
// const ui_attribute_type_color = 5
// const ui_attribute_type_background = 6
// const ui_attribute_type_underline = 7
// const ui_attribute_type_underline_color = 8
// const ui_attribute_type_features = 9

// uiAttributeGetType() returns the type of a.
// TODO I don't like this name
pub fn C.uiAttributeGetType(a &C.uiAttribute) C.uiAttributeType

pub fn ui_attribute_get_type(a &C.uiAttribute) C.uiAttributeType {
	return C.uiAttributeGetType(a)
}

// uiNewFamilyAttribute() creates a new uiAttribute that changes the
// font family of the text it is applied to. family is copied; you do not
// need to keep it alive after uiNewFamilyAttribute() returns. Font
// family names are case-insensitive.
pub fn C.uiNewFamilyAttribute(family &i8) &C.uiAttribute

pub fn ui_new_family_attribute(family &i8) &C.uiAttribute {
	return C.uiNewFamilyAttribute(family)
}

// uiAttributeFamily() returns the font family stored in a. The
// returned string is owned by a. It is an error to call this on a
// uiAttribute that does not hold a font family.
pub fn C.uiAttributeFamily(a &C.uiAttribute) &i8

pub fn ui_attribute_family(a &C.uiAttribute) &i8 {
	return C.uiAttributeFamily(a)
}

// uiNewSizeAttribute() creates a new uiAttribute that changes the
// size of the text it is applied to, in typographical points.
pub fn C.uiNewSizeAttribute(size f64) &C.uiAttribute

pub fn ui_new_size_attribute(size f64) &C.uiAttribute {
	return C.uiNewSizeAttribute(size)
}

// uiAttributeSize() returns the font size stored in a. It is an error to
// call this on a uiAttribute that does not hold a font size.
pub fn C.uiAttributeSize(a &C.uiAttribute) f64

pub fn ui_attribute_size(a &C.uiAttribute) f64 {
	return C.uiAttributeSize(a)
}

// uiTextWeight represents possible text weights. These roughly
// map to the OS/2 text weight field of TrueType and OpenType
// fonts, or to CSS weight numbers. The named constants are
// nominal values; the actual values may vary by font and by OS,
// though this isn't particularly likely. Any value between
// uiTextWeightMinimum and uiTextWeightMaximum, inclusive,
// is allowed.
//
// Note that due to restrictions in early versions of Windows, some
// fonts have "special" weights be exposed in many programs as
// separate font families. This is perhaps most notable with
// Arial Black. libui does not do this, even on Windows (because the
// DirectWrite API libui uses on Windows does not do this); to
// specify Arial Black, use family Arial and weight uiTextWeightBlack.
pub type UiTextWeight = u32

// empty enum
const ui_text_weight_minimum = 0
const ui_text_weight_thin = 100
const ui_text_weight_ultra_light = 200
const ui_text_weight_light = 300
const ui_text_weight_book = 350
const ui_text_weight_normal = 400
const ui_text_weight_medium = 500
const ui_text_weight_semi_bold = 600
const ui_text_weight_bold = 700
const ui_text_weight_ultra_bold = 800
const ui_text_weight_heavy = 900
const ui_text_weight_ultra_heavy = 950
const ui_text_weight_maximum = 1000

// uiNewWeightAttribute() creates a new uiAttribute that changes the
// weight of the text it is applied to. It is an error to specify a weight
// outside the range [uiTextWeightMinimum,
// uiTextWeightMaximum].
pub fn C.uiNewWeightAttribute(weight UiTextWeight) &C.uiAttribute

pub fn ui_new_weight_attribute(weight UiTextWeight) &C.uiAttribute {
	return C.uiNewWeightAttribute(weight)
}

// uiAttributeWeight() returns the font weight stored in a. It is an error
// to call this on a uiAttribute that does not hold a font weight.
pub fn C.uiAttributeWeight(a &C.uiAttribute) UiTextWeight

pub fn ui_attribute_weight(a &C.uiAttribute) UiTextWeight {
	return C.uiAttributeWeight(a)
}

// uiTextItalic represents possible italic modes for a font. Italic
// represents "true" italics where the slanted glyphs have custom
// shapes, whereas oblique represents italics that are merely slanted
// versions of the normal glyphs. Most fonts usually have one or the
// other.
pub type UiTextItalic = u32

// empty enum
const ui_text_italic_normal = 0
const ui_text_italic_oblique = 1
const ui_text_italic_italic = 2

// uiNewItalicAttribute() creates a new uiAttribute that changes the
// italic mode of the text it is applied to. It is an error to specify an
// italic mode not specified in uiTextItalic.
pub fn C.uiNewItalicAttribute(italic UiTextItalic) &C.uiAttribute

pub fn ui_new_italic_attribute(italic UiTextItalic) &C.uiAttribute {
	return C.uiNewItalicAttribute(italic)
}

// uiAttributeItalic() returns the font italic mode stored in a. It is an
// error to call this on a uiAttribute that does not hold a font italic
// mode.
pub fn C.uiAttributeItalic(a &C.uiAttribute) UiTextItalic

pub fn ui_attribute_italic(a &C.uiAttribute) UiTextItalic {
	return C.uiAttributeItalic(a)
}

// uiTextStretch represents possible stretches (also called "widths")
// of a font.
//
// Note that due to restrictions in early versions of Windows, some
// fonts have "special" stretches be exposed in many programs as
// separate font families. This is perhaps most notable with
// Arial Condensed. libui does not do this, even on Windows (because
// the DirectWrite API libui uses on Windows does not do this); to
// specify Arial Condensed, use family Arial and stretch
// uiTextStretchCondensed.
pub type UiTextStretch = u32

// empty enum
const ui_text_stretch_ultra_condensed = 0
const ui_text_stretch_extra_condensed = 1
const ui_text_stretch_condensed = 2
const ui_text_stretch_semi_condensed = 3
const ui_text_stretch_normal = 4
const ui_text_stretch_semi_expanded = 5
const ui_text_stretch_expanded = 6
const ui_text_stretch_extra_expanded = 7
const ui_text_stretch_ultra_expanded = 8

// uiNewStretchAttribute() creates a new uiAttribute that changes the
// stretch of the text it is applied to. It is an error to specify a strech
// not specified in uiTextStretch.
pub fn C.uiNewStretchAttribute(stretch UiTextStretch) &C.uiAttribute

pub fn ui_new_stretch_attribute(stretch UiTextStretch) &C.uiAttribute {
	return C.uiNewStretchAttribute(stretch)
}

// uiAttributeStretch() returns the font stretch stored in a. It is an
// error to call this on a uiAttribute that does not hold a font stretch.
pub fn C.uiAttributeStretch(a &C.uiAttribute) UiTextStretch

pub fn ui_attribute_stretch(a &C.uiAttribute) UiTextStretch {
	return C.uiAttributeStretch(a)
}

// uiNewColorAttribute() creates a new uiAttribute that changes the
// color of the text it is applied to. It is an error to specify an invalid
// color.
pub fn C.uiNewColorAttribute(r f64, g f64, b f64, a f64) &C.uiAttribute

pub fn ui_new_color_attribute(r f64, g f64, b f64, a f64) &C.uiAttribute {
	return C.uiNewColorAttribute(r, g, b, a)
}

// uiAttributeColor() returns the text color stored in a. It is an
// error to call this on a uiAttribute that does not hold a text color.
pub fn C.uiAttributeColor(a &C.uiAttribute, r &f64, g &f64, b &f64, alpha &f64)

pub fn ui_attribute_color(a &C.uiAttribute, r &f64, g &f64, b &f64, alpha &f64) {
	C.uiAttributeColor(a, r, g, b, alpha)
}

// uiNewBackgroundAttribute() creates a new uiAttribute that
// changes the background color of the text it is applied to. It is an
// error to specify an invalid color.
pub fn C.uiNewBackgroundAttribute(r f64, g f64, b f64, a f64) &C.uiAttribute

pub fn ui_new_background_attribute(r f64, g f64, b f64, a f64) &C.uiAttribute {
	return C.uiNewBackgroundAttribute(r, g, b, a)
}

// TODO reuse uiAttributeColor() for background colors, or make a new function...
// uiUnderline specifies a type of underline to use on text.
pub type UiUnderline = u32

// empty enum
const ui_underline_none = 0
const ui_underline_single = 1
const ui_underline_double = 2
const ui_underline_suggestion = 3 // wavy or dotted underlines used for spelling/grammar checkers

// uiNewUnderlineAttribute() creates a new uiAttribute that changes
// the type of underline on the text it is applied to. It is an error to
// specify an underline type not specified in uiUnderline.
pub fn C.uiNewUnderlineAttribute(u UiUnderline) &C.uiAttribute

pub fn ui_new_underline_attribute(u UiUnderline) &C.uiAttribute {
	return C.uiNewUnderlineAttribute(u)
}

// uiAttributeUnderline() returns the underline type stored in a. It is
// an error to call this on a uiAttribute that does not hold an underline
// style.
pub fn C.uiAttributeUnderline(a &C.uiAttribute) UiUnderline

pub fn ui_attribute_underline(a &C.uiAttribute) UiUnderline {
	return C.uiAttributeUnderline(a)
}

// uiUnderlineColor specifies the color of any underline on the text it
// is applied to, regardless of the type of underline. In addition to
// being able to specify a custom color, you can explicitly specify
// platform-specific colors for suggestion underlines; to use them
// correctly, pair them with uiUnderlineSuggestion (though they can
// be used on other types of underline as well).
//
// If an underline type is applied but no underline color is
// specified, the text color is used instead. If an underline color
// is specified without an underline type, the underline color
// attribute is ignored, but not removed from the uiAttributedString.
pub type UiUnderlineColor = u32

// empty enum
const ui_underline_color_custom = 0
const ui_underline_color_spelling = 1
const ui_underline_color_grammar = 2
const ui_underline_color_auxiliary = 3 // for instance, the color used by smart replacements on macOS or in Microsoft Office

// uiNewUnderlineColorAttribute() creates a new uiAttribute that
// changes the color of the underline on the text it is applied to.
// It is an error to specify an underline color not specified in
// uiUnderlineColor.
//
// If the specified color type is uiUnderlineColorCustom, it is an
// error to specify an invalid color value. Otherwise, the color values
// are ignored and should be specified as zero.
pub fn C.uiNewUnderlineColorAttribute(u UiUnderlineColor, r f64, g f64, b f64, a f64) &C.uiAttribute

pub fn ui_new_underline_color_attribute(u UiUnderlineColor, r f64, g f64, b f64, a f64) &C.uiAttribute {
	return C.uiNewUnderlineColorAttribute(u, r, g, b, a)
}

// uiAttributeUnderlineColor() returns the underline color stored in
// a. It is an error to call this on a uiAttribute that does not hold an
// underline color.
pub fn C.uiAttributeUnderlineColor(a &C.uiAttribute, u C.uiUnderlineColor, r &f64, g &f64, b &f64, alpha &f64)

pub fn ui_attribute_underline_color(a &C.uiAttribute, u C.uiUnderlineColor, r &f64, g &f64, b &f64, alpha &f64) {
	C.uiAttributeUnderlineColor(a, u, r, g, b, alpha)
}

// uiOpenTypeFeatures represents a set of OpenType feature
// tag-value pairs, for applying OpenType features to text.
// OpenType feature tags are four-character codes defined by
// OpenType that cover things from design features like small
// caps and swashes to language-specific glyph shapes and
// beyond. Each tag may only appear once in any given
// uiOpenTypeFeatures instance. Each value is a 32-bit integer,
// often used as a Boolean flag, but sometimes as an index to choose
// a glyph shape to use.
//
// If a font does not support a certain feature, that feature will be
// ignored. (TODO verify this on all OSs)
//
// See the OpenType specification at
// https://www.microsoft.com/typography/otspec/featuretags.htm
// for the complete list of available features, information on specific
// features, and how to use them.
// TODO invalid features
// uiOpenTypeFeaturesForEachFunc is the type of the function
// invoked by uiOpenTypeFeaturesForEach() for every OpenType
// feature in otf. Refer to that function's documentation for more
// details.
pub type UiOpenTypeFeaturesForEachFunc = fn (&C.uiOpenTypeFeatures, i8, i8, i8, i8, u32, voidptr) C.uiForEach

// @role uiOpenTypeFeatures constructor
// uiNewOpenTypeFeatures() returns a new uiOpenTypeFeatures
// instance, with no tags yet added.
pub fn C.uiNewOpenTypeFeatures() &C.uiOpenTypeFeatures

pub fn ui_new_open_type_features() &C.uiOpenTypeFeatures {
	return C.uiNewOpenTypeFeatures()
}

// @role uiOpenTypeFeatures destructor
// uiFreeOpenTypeFeatures() frees otf.
pub fn C.uiFreeOpenTypeFeatures(otf &C.uiOpenTypeFeatures)

pub fn ui_free_open_type_features(otf &C.uiOpenTypeFeatures) {
	C.uiFreeOpenTypeFeatures(otf)
}

// uiOpenTypeFeaturesClone() makes a copy of otf and returns it.
// Changing one will not affect the other.
pub fn C.uiOpenTypeFeaturesClone(otf &C.uiOpenTypeFeatures) &C.uiOpenTypeFeatures

pub fn ui_open_type_features_clone(otf &C.uiOpenTypeFeatures) &C.uiOpenTypeFeatures {
	return C.uiOpenTypeFeaturesClone(otf)
}

// uiOpenTypeFeaturesAdd() adds the given feature tag and value
// to otf. The feature tag is specified by a, b, c, and d. If there is
// already a value associated with the specified tag in otf, the old
// value is removed.
pub fn C.uiOpenTypeFeaturesAdd(otf &C.uiOpenTypeFeatures, a i8, b i8, c i8, d i8, value u32)

pub fn ui_open_type_features_add(otf &C.uiOpenTypeFeatures, a i8, b i8, c i8, d i8, value u32) {
	C.uiOpenTypeFeaturesAdd(otf, a, b, c, d, value)
}

// uiOpenTypeFeaturesRemove() removes the given feature tag
// and value from otf. If the tag is not present in otf,
// uiOpenTypeFeaturesRemove() does nothing.
pub fn C.uiOpenTypeFeaturesRemove(otf &C.uiOpenTypeFeatures, a i8, b i8, c i8, d i8)

pub fn ui_open_type_features_remove(otf &C.uiOpenTypeFeatures, a i8, b i8, c i8, d i8) {
	C.uiOpenTypeFeaturesRemove(otf, a, b, c, d)
}

// uiOpenTypeFeaturesGet() determines whether the given feature
// tag is present in otf. If it is, *value is set to the tag's value and
// nonzero is returned. Otherwise, zero is returned.
//
// Note that if uiOpenTypeFeaturesGet() returns zero, value isn't
// changed. This is important: if a feature is not present in a
// uiOpenTypeFeatures, the feature is NOT treated as if its
// value was zero anyway. Script-specific font shaping rules and
// font-specific feature settings may use a different default value
// for a feature. You should likewise not treat a missing feature as
// having a value of zero either. Instead, a missing feature should
// be treated as having some unspecified default value.
pub fn C.uiOpenTypeFeaturesGet(otf &C.uiOpenTypeFeatures, a i8, b i8, c i8, d i8, value &u32) int

pub fn ui_open_type_features_get(otf &C.uiOpenTypeFeatures, a i8, b i8, c i8, d i8, value &u32) int {
	return C.uiOpenTypeFeaturesGet(otf, a, b, c, d, value)
}

// uiOpenTypeFeaturesForEach() executes f for every tag-value
// pair in otf. The enumeration order is unspecified. You cannot
// modify otf while uiOpenTypeFeaturesForEach() is running.
pub fn C.uiOpenTypeFeaturesForEach(otf &C.uiOpenTypeFeatures, f UiOpenTypeFeaturesForEachFunc, data voidptr)

pub fn ui_open_type_features_for_each(otf &C.uiOpenTypeFeatures, f UiOpenTypeFeaturesForEachFunc, data voidptr) {
	C.uiOpenTypeFeaturesForEach(otf, f, data)
}

// uiNewFeaturesAttribute() creates a new uiAttribute that changes
// the font family of the text it is applied to. otf is copied; you may
// free it after uiNewFeaturesAttribute() returns.
pub fn C.uiNewFeaturesAttribute(otf &C.uiOpenTypeFeatures) &C.uiAttribute

pub fn ui_new_features_attribute(otf &C.uiOpenTypeFeatures) &C.uiAttribute {
	return C.uiNewFeaturesAttribute(otf)
}

// uiAttributeFeatures() returns the OpenType features stored in a.
// The returned uiOpenTypeFeatures object is owned by a. It is an
// error to call this on a uiAttribute that does not hold OpenType
// features.
pub fn C.uiAttributeFeatures(a &C.uiAttribute) &C.uiOpenTypeFeatures

pub fn ui_attribute_features(a &C.uiAttribute) &C.uiOpenTypeFeatures {
	return C.uiAttributeFeatures(a)
}

// uiAttributedString represents a string of UTF-8 text that can
// optionally be embellished with formatting attributes. libui
// provides the list of formatting attributes, which cover common
// formatting traits like boldface and color as well as advanced
// typographical features provided by OpenType like superscripts
// and small caps. These attributes can be combined in a variety of
// ways.
//
// Attributes are applied to runs of Unicode codepoints in the string.
// Zero-length runs are elided. Consecutive runs that have the same
// attribute type and value are merged. Each attribute is independent
// of each other attribute; overlapping attributes of different types
// do not split each other apart, but different values of the same
// attribute type do.
//
// The empty string can also be represented by uiAttributedString,
// but because of the no-zero-length-attribute rule, it will not have
// attributes.
//
// A uiAttributedString takes ownership of all attributes given to
// it, as it may need to duplicate or delete uiAttribute objects at
// any time. By extension, when you free a uiAttributedString,
// all uiAttributes within will also be freed. Each method will
// describe its own rules in more details.
//
// In addition, uiAttributedString provides facilities for moving
// between grapheme clusters, which represent a character
// from the point of view of the end user. The cursor of a text editor
// is always placed on a grapheme boundary, so you can use these
// features to move the cursor left or right by one "character".
// TODO does uiAttributedString itself need this
//
// uiAttributedString does not provide enough information to be able
// to draw itself onto a uiDrawContext or respond to user actions.
// In order to do that, you'll need to use a uiDrawTextLayout, which
// is built from the combination of a uiAttributedString and a set of
// layout-specific properties.
// uiAttributedStringForEachAttributeFunc is the type of the function
// invoked by uiAttributedStringForEachAttribute() for every
// attribute in s. Refer to that function's documentation for more
// details.
pub type UiAttributedStringForEachAttributeFunc = fn (&C.uiAttributedString, &C.uiAttribute, usize, usize, voidptr) C.uiForEach

// @role uiAttributedString constructor
// uiNewAttributedString() creates a new uiAttributedString from
// initialString. The string will be entirely unattributed.
pub fn C.uiNewAttributedString(initial_string &i8) &C.uiAttributedString

pub fn ui_new_attributed_string(initial_string &i8) &C.uiAttributedString {
	return C.uiNewAttributedString(initial_string)
}

// @role uiAttributedString destructor
// uiFreeAttributedString() destroys the uiAttributedString s.
// It will also free all uiAttributes within.
pub fn C.uiFreeAttributedString(s &C.uiAttributedString)

pub fn ui_free_attributed_string(s &C.uiAttributedString) {
	C.uiFreeAttributedString(s)
}

// uiAttributedStringString() returns the textual content of s as a
// '\0'-terminated UTF-8 string. The returned pointer is valid until
// the next change to the textual content of s.
pub fn C.uiAttributedStringString(s &C.uiAttributedString) &i8

pub fn ui_attributed_string_string(s &C.uiAttributedString) &i8 {
	return C.uiAttributedStringString(s)
}

// uiAttributedStringLength() returns the number of UTF-8 bytes in
// the textual content of s, excluding the terminating '\0'.
pub fn C.uiAttributedStringLen(s &C.uiAttributedString) usize

pub fn ui_attributed_string_len(s &C.uiAttributedString) usize {
	return C.uiAttributedStringLen(s)
}

// uiAttributedStringAppendUnattributed() adds the '\0'-terminated
// UTF-8 string str to the end of s. The new substring will be
// unattributed.
pub fn C.uiAttributedStringAppendUnattributed(s &C.uiAttributedString, str &i8)

pub fn ui_attributed_string_append_unattributed(s &C.uiAttributedString, str &i8) {
	C.uiAttributedStringAppendUnattributed(s, str)
}

// uiAttributedStringInsertAtUnattributed() adds the '\0'-terminated
// UTF-8 string str to s at the byte position specified by at. The new
// substring will be unattributed; existing attributes will be moved
// along with their text.
pub fn C.uiAttributedStringInsertAtUnattributed(s &C.uiAttributedString, str &i8, at usize)

pub fn ui_attributed_string_insert_at_unattributed(s &C.uiAttributedString, str &i8, at usize) {
	C.uiAttributedStringInsertAtUnattributed(s, str, at)
}

// TODO add the Append and InsertAtExtendingAttributes functions
// TODO and add functions that take a string + length
// uiAttributedStringDelete() deletes the characters and attributes of
// s in the byte range [start, end).
pub fn C.uiAttributedStringDelete(s &C.uiAttributedString, start usize, end usize)

pub fn ui_attributed_string_delete(s &C.uiAttributedString, start usize, end usize) {
	C.uiAttributedStringDelete(s, start, end)
}

// TODO add a function to uiAttributedString to get an attribute's value at a specific index or in a specific range, so we can edit
// uiAttributedStringSetAttribute() sets a in the byte range [start, end)
// of s. Any existing attributes in that byte range of the same type are
// removed. s takes ownership of a; you should not use it after
// uiAttributedStringSetAttribute() returns.
pub fn C.uiAttributedStringSetAttribute(s &C.uiAttributedString, a &C.uiAttribute, start usize, end usize)

pub fn ui_attributed_string_set_attribute(s &C.uiAttributedString, a &C.uiAttribute, start usize, end usize) {
	C.uiAttributedStringSetAttribute(s, a, start, end)
}

// uiAttributedStringForEachAttribute() enumerates all the
// uiAttributes in s. It is an error to modify s in f. Within f, s still
// owns the attribute; you can neither free it nor save it for later
// use.
// TODO reword the above for consistency (TODO and find out what I meant by that)
// TODO define an enumeration order (or mark it as undefined); also define how consecutive runs of identical attributes are handled here and sync with the definition of uiAttributedString itself
pub fn C.uiAttributedStringForEachAttribute(s &C.uiAttributedString, f UiAttributedStringForEachAttributeFunc, data voidptr)

pub fn ui_attributed_string_for_each_attribute(s &C.uiAttributedString, f UiAttributedStringForEachAttributeFunc, data voidptr) {
	C.uiAttributedStringForEachAttribute(s, f, data)
}

// TODO const correct this somehow (the implementation needs to mutate the structure)
pub fn C.uiAttributedStringNumGraphemes(s &C.uiAttributedString) usize

pub fn ui_attributed_string_num_graphemes(s &C.uiAttributedString) usize {
	return C.uiAttributedStringNumGraphemes(s)
}

// TODO const correct this somehow (the implementation needs to mutate the structure)
pub fn C.uiAttributedStringByteIndexToGrapheme(s &C.uiAttributedString, pos usize) usize

pub fn ui_attributed_string_byte_index_to_grapheme(s &C.uiAttributedString, pos usize) usize {
	return C.uiAttributedStringByteIndexToGrapheme(s, pos)
}

// TODO const correct this somehow (the implementation needs to mutate the structure)
pub fn C.uiAttributedStringGraphemeToByteIndex(s &C.uiAttributedString, pos usize) usize

pub fn ui_attributed_string_grapheme_to_byte_index(s &C.uiAttributedString, pos usize) usize {
	return C.uiAttributedStringGraphemeToByteIndex(s, pos)
}

// uiFontDescriptor provides a complete description of a font where
// one is needed. Currently, this means as the default font of a
// uiDrawTextLayout and as the data returned by uiFontButton.
// All the members operate like the respective uiAttributes.
pub struct C.uiFontDescriptor {
	// TODO const-correct this or figure out how to deal with this when getting a value
	Family  &i8
	Size    f64
	Weight  UiTextWeight
	Italic  UiTextItalic
	Stretch UiTextStretch
}

// uiDrawTextLayout is a concrete representation of a
// uiAttributedString that can be displayed in a uiDrawContext.
// It includes information important for the drawing of a block of
// text, including the bounding box to wrap the text within, the
// alignment of lines of text within that box, areas to mark as
// being selected, and other things.
//
// Unlike uiAttributedString, the content of a uiDrawTextLayout is
// immutable once it has been created.
//
// TODO talk about OS-specific differences with text drawing that libui can't account for...
// uiDrawTextAlign specifies the alignment of lines of text in a
// uiDrawTextLayout.
// TODO should this really have Draw in the name?
pub type UiDrawTextAlign = u32

// empty enum
const ui_draw_text_align_left = 0
const ui_draw_text_align_center = 1
const ui_draw_text_align_right = 2

// uiDrawTextLayoutParams describes a uiDrawTextLayout.
// DefaultFont is used to render any text that is not attributed
// sufficiently in String. Width determines the width of the bounding
// box of the text; the height is determined automatically.
// TODO const-correct this somehow
pub struct C.uiDrawTextLayoutParams {
	String      C.uiAttributedString
	DefaultFont C.uiFontDescriptor
	Width       f64
	Align       UiDrawTextAlign
}

// @role uiDrawTextLayout constructor
// uiDrawNewTextLayout() creates a new uiDrawTextLayout from
// the given parameters.
//
// TODO
// - allow creating a layout out of a substring
// - allow marking compositon strings
// - allow marking selections, even after creation
// - add the following functions:
// 	- uiDrawTextLayoutHeightForWidth() (returns the height that a layout would need to be to display the entire string at a given width)
// 	- uiDrawTextLayoutRangeForSize() (returns what substring would fit in a given size)
// 	- uiDrawTextLayoutNewWithHeight() (limits amount of string used by the height)
// - some function to fix up a range (for text editing)
pub fn C.uiDrawNewTextLayout(params &C.uiDrawTextLayoutParams) &C.uiDrawTextLayout

pub fn ui_draw_new_text_layout(params &C.uiDrawTextLayoutParams) &C.uiDrawTextLayout {
	return C.uiDrawNewTextLayout(params)
}

// @role uiDrawFreeTextLayout destructor
// uiDrawFreeTextLayout() frees tl. The underlying
// uiAttributedString is not freed.
pub fn C.uiDrawFreeTextLayout(tl &C.uiDrawTextLayout)

pub fn ui_draw_free_text_layout(tl &C.uiDrawTextLayout) {
	C.uiDrawFreeTextLayout(tl)
}

// uiDrawText() draws tl in c with the top-left point of tl at (x, y).
pub fn C.uiDrawText(c &C.uiDrawContext, tl &C.uiDrawTextLayout, x f64, y f64)

pub fn ui_draw_text(c &C.uiDrawContext, tl &C.uiDrawTextLayout, x f64, y f64) {
	C.uiDrawText(c, tl, x, y)
}

// uiDrawTextLayoutExtents() returns the width and height of tl
// in width and height. The returned width may be smaller than
// the width passed into uiDrawNewTextLayout() depending on
// how the text in tl is wrapped. Therefore, you can use this
// function to get the actual size of the text layout.
pub fn C.uiDrawTextLayoutExtents(tl &C.uiDrawTextLayout, width &f64, height &f64)

pub fn ui_draw_text_layout_extents(tl &C.uiDrawTextLayout, width &f64, height &f64) {
	C.uiDrawTextLayoutExtents(tl, width, height)
}

// TODO metrics functions
// TODO number of lines visible for clipping rect, range visible for clipping rect?
// uiFontButton is a button that allows users to choose a font when they click on it.
// uiFontButtonFont() returns the font currently selected in the uiFontButton in desc.
// uiFontButtonFont() allocates resources in desc; when you are done with the font, call uiFreeFontButtonFont() to release them.
// uiFontButtonFont() does not allocate desc itself; you must do so.
// TODO have a function that sets an entire font descriptor to a range in a uiAttributedString at once, for SetFont?
pub fn C.uiFontButtonFont(b &C.uiFontButton, desc &C.uiFontDescriptor)

pub fn ui_font_button_font(b &C.uiFontButton, desc &C.uiFontDescriptor) {
	C.uiFontButtonFont(b, desc)
}

// TOOD SetFont, mechanics
// uiFontButtonOnChanged() sets the function that is called when the font in the uiFontButton is changed.
pub fn C.uiFontButtonOnChanged(b &C.uiFontButton, f fn (&C.uiFontButton, voidptr), data voidptr)

pub fn ui_font_button_on_changed(b &C.uiFontButton, f fn (&C.uiFontButton, voidptr), data voidptr) {
	C.uiFontButtonOnChanged(b, f, data)
}

// uiNewFontButton() creates a new uiFontButton. The default font selected into the uiFontButton is OS-defined.
pub fn C.uiNewFontButton() &C.uiFontButton

pub fn ui_new_font_button() &C.uiFontButton {
	return C.uiNewFontButton()
}

// uiFreeFontButtonFont() frees resources allocated in desc by uiFontButtonFont().
// After calling uiFreeFontButtonFont(), the contents of desc should be assumed to be undefined (though since you allocate desc itself, you can safely reuse desc for other font descriptors).
// Calling uiFreeFontButtonFont() on a uiFontDescriptor not returned by uiFontButtonFont() results in undefined behavior.
pub fn C.uiFreeFontButtonFont(desc &C.uiFontDescriptor)

pub fn ui_free_font_button_font(desc &C.uiFontDescriptor) {
	C.uiFreeFontButtonFont(desc)
}

pub type UiModifiers = u32

// empty enum
const ui_modifier_ctrl = 1 << 0
const ui_modifier_alt = 1 << 1
const ui_modifier_shift = 1 << 2
const ui_modifier_super = 1 << 3

// TODO document drag captures
pub struct C.uiAreaMouseEvent {
	// TODO document what these mean for scrolling areas
	x f64
	y f64
	// TODO see draw above
	areaWidth  f64
	areaHeight f64
	down       int
	up         int
	count      int
	modifiers  UiModifiers
	held1To64  u64
}

pub type UiExtKey = int

// empty enum
const ui_ext_key_escape = 1
const ui_ext_key_insert = 1
// equivalent to "Help" on Apple keyboards
const ui_ext_key_delete = 2
const ui_ext_key_home = 3
const ui_ext_key_end = 4
const ui_ext_key_page_up = 5
const ui_ext_key_page_down = 6
const ui_ext_key_up = 7
const ui_ext_key_down = 8
const ui_ext_key_left = 9
const ui_ext_key_right = 10
const ui_ext_key_f1 = 11
// F1..F12 are guaranteed to be consecutive
const ui_ext_key_f2 = 12
const ui_ext_key_f3 = 13
const ui_ext_key_f4 = 14
const ui_ext_key_f5 = 15
const ui_ext_key_f6 = 16
const ui_ext_key_f7 = 17
const ui_ext_key_f8 = 18
const ui_ext_key_f9 = 19
const ui_ext_key_f10 = 20
const ui_ext_key_f11 = 21
const ui_ext_key_f12 = 22
const ui_ext_key_n0 = 23
// numpad keys; independent of Num Lock state
const ui_ext_key_n1 = 24
// N0..N9 are guaranteed to be consecutive
const ui_ext_key_n2 = 25
const ui_ext_key_n3 = 26
const ui_ext_key_n4 = 27
const ui_ext_key_n5 = 28
const ui_ext_key_n6 = 29
const ui_ext_key_n7 = 30
const ui_ext_key_n8 = 31
const ui_ext_key_n9 = 32
const ui_ext_key_nd_ot = 33
const ui_ext_key_ne_nter = 34
const ui_ext_key_na_dd = 35
const ui_ext_key_ns_ubtract = 36
const ui_ext_key_nm_ultiply = 37
const ui_ext_key_nd_ivide = 38

pub struct C.uiAreaKeyEvent {
	key       i8
	extKey    UiExtKey
	modifier  UiModifiers
	modifiers UiModifiers
	up        int
}

pub fn C.uiColorButtonColor(b &C.uiColorButton, r &f64, g &f64, bl &f64, a &f64)

pub fn ui_color_button_color(b &C.uiColorButton, r &f64, g &f64, bl &f64, a &f64) {
	C.uiColorButtonColor(b, r, g, bl, a)
}

pub fn C.uiColorButtonSetColor(b &C.uiColorButton, r f64, g f64, bl f64, a f64)

pub fn ui_color_button_set_color(b &C.uiColorButton, r f64, g f64, bl f64, a f64) {
	C.uiColorButtonSetColor(b, r, g, bl, a)
}

pub fn C.uiColorButtonOnChanged(b &C.uiColorButton, f fn (&C.uiColorButton, voidptr), data voidptr)

pub fn ui_color_button_on_changed(b &C.uiColorButton, f fn (&C.uiColorButton, voidptr), data voidptr) {
	C.uiColorButtonOnChanged(b, f, data)
}

pub fn C.uiNewColorButton() &C.uiColorButton

pub fn ui_new_color_button() &C.uiColorButton {
	return C.uiNewColorButton()
}

pub fn C.uiFormAppend(f &C.uiForm, label &i8, c &C.uiControl, stretchy int)

pub fn ui_form_append(f &C.uiForm, label &i8, c &C.uiControl, stretchy int) {
	C.uiFormAppend(f, label, c, stretchy)
}

pub fn C.uiFormDelete(f &C.uiForm, index int)

pub fn ui_form_delete(f &C.uiForm, index int) {
	C.uiFormDelete(f, index)
}

pub fn C.uiFormPadded(f &C.uiForm) int

pub fn ui_form_padded(f &C.uiForm) int {
	return C.uiFormPadded(f)
}

pub fn C.uiFormSetPadded(f &C.uiForm, padded int)

pub fn ui_form_set_padded(f &C.uiForm, padded int) {
	C.uiFormSetPadded(f, padded)
}

pub fn C.uiNewForm() &C.uiForm

pub fn ui_new_form() &C.uiForm {
	return C.uiNewForm()
}

pub type UiAlign = u32

enum UiAt {
	ui_align_fill
	ui_align_start
	ui_align_center
	ui_align_end
}

// empty enum
const ui_at_leading = 0
const ui_at_top = 1
const ui_at_trailing = 2
const ui_at_bottom = 3

pub fn C.uiGridAppend(g &C.uiGrid, c &C.uiControl, left int, top int, xspan int, yspan int, hexpand int, halign UiAlign, vexpand int, valign UiAlign)

pub fn ui_grid_append(g &C.uiGrid, c &C.uiControl, left int, top int, xspan int, yspan int, hexpand int, halign UiAlign, vexpand int, valign UiAlign) {
	C.uiGridAppend(g, c, left, top, xspan, yspan, hexpand, halign, vexpand, valign)
}

pub fn C.uiGridInsertAt(g &C.uiGrid, c &C.uiControl, existing &C.uiControl, at UiAt, xspan int, yspan int, hexpand int, halign UiAlign, vexpand int, valign UiAlign)

pub fn ui_grid_insert_at(g &C.uiGrid, c &C.uiControl, existing &C.uiControl, at UiAt, xspan int, yspan int, hexpand int, halign UiAlign, vexpand int, valign UiAlign) {
	C.uiGridInsertAt(g, c, existing, at, xspan, yspan, hexpand, halign, vexpand, valign)
}

pub fn C.uiGridPadded(g &C.uiGrid) int

pub fn ui_grid_padded(g &C.uiGrid) int {
	return C.uiGridPadded(g)
}

pub fn C.uiGridSetPadded(g &C.uiGrid, padded int)

pub fn ui_grid_set_padded(g &C.uiGrid, padded int) {
	C.uiGridSetPadded(g, padded)
}

pub fn C.uiNewGrid() &C.uiGrid

pub fn ui_new_grid() &C.uiGrid {
	return C.uiNewGrid()
}

// uiImage stores an image for display on screen.
//
// Images are built from one or more representations, each with the
// same aspect ratio but a different pixel size. libui automatically
// selects the most appropriate representation for drawing the image
// when it comes time to draw the image; what this means depends
// on the pixel density of the target context. Therefore, one can use
// uiImage to draw higher-detailed images on higher-density
// displays. The typical use cases are either:
//
// 	- have just a single representation, at which point all screens
// 	  use the same image, and thus uiImage acts like a simple
// 	  bitmap image, or
// 	- have two images, one at normal resolution and one at 2x
// 	  resolution; this matches the current expectations of some
// 	  desktop systems at the time of writing (mid-2018)
//
// uiImage is very simple: it only supports premultiplied 32-bit
// RGBA images, and libui does not provide any image file loading
// or image format conversion utilities on top of that.
// @role uiImage constructor
// uiNewImage creates a new uiImage with the given width and
// height. This width and height should be the size in points of the
// image in the device-independent case; typically this is the 1x size.
// TODO for all uiImage functions: use const void * for const correctness
pub fn C.uiNewImage(width f64, height f64) &C.uiImage

pub fn ui_new_image(width f64, height f64) &C.uiImage {
	return C.uiNewImage(width, height)
}

// @role uiImage destructor
// uiFreeImage frees the given image and all associated resources.
pub fn C.uiFreeImage(i &C.uiImage)

pub fn ui_free_image(i &C.uiImage) {
	C.uiFreeImage(i)
}

// uiImageAppend adds a representation to the uiImage.
// pixels should point to a byte array of premultiplied pixels
// stored in [R G B A] order (so ((uint8_t *) pixels)[0] is the R of the
// first pixel and [3] is the A of the first pixel). pixelWidth and
// pixelHeight is the size *in pixels* of the image, and pixelStride is
// the number *of bytes* per row of the pixels array. Therefore,
// pixels itself must be at least byteStride * pixelHeight bytes long.
// TODO see if we either need the stride or can provide a way to get the OS-preferred stride (in cairo we do)
pub fn C.uiImageAppend(i &C.uiImage, pixels voidptr, pixel_width int, pixel_height int, byte_stride int)

pub fn ui_image_append(i &C.uiImage, pixels voidptr, pixel_width int, pixel_height int, byte_stride int) {
	C.uiImageAppend(i, pixels, pixel_width, pixel_height, byte_stride)
}

// uiTableValue stores a value to be passed along uiTable and
// uiTableModel.
//
// You do not create uiTableValues directly; instead, you create a
// uiTableValue of a given type using the specialized constructor
// functions.
//
// uiTableValues are immutable and the uiTableModel and uiTable
// take ownership of the uiTableValue object once returned, copying
// its contents as necessary.
// @role uiTableValue destructor
// uiFreeTableValue() frees a uiTableValue. You generally do not
// need to call this yourself, as uiTable and uiTableModel do this
// for you. In fact, it is an error to call this function on a uiTableValue
// that has been given to a uiTable or uiTableModel. You can call this,
// however, if you created a uiTableValue that you aren't going to
// use later, or if you called a uiTableModelHandler method directly
// and thus never transferred ownership of the uiTableValue.
pub fn C.uiFreeTableValue(v &C.uiTableValue)

pub fn ui_free_table_value(v &C.uiTableValue) {
	C.uiFreeTableValue(v)
}

// uiTableValueType holds the possible uiTableValue types that may
// be returned by uiTableValueGetType(). Refer to the documentation
// for each type's constructor function for details on each type.
// TODO actually validate these
pub type UiTableValueType = u32

// empty enum
const ui_table_value_type_string = 0
const ui_table_value_type_image = 1
const ui_table_value_type_int = 2
const ui_table_value_type_color = 3

// uiTableValueGetType() returns the type of v.
// TODO I don't like this name
pub fn C.uiTableValueGetType(v &C.uiTableValue) UiTableValueType

pub fn ui_table_value_get_type(v &C.uiTableValue) UiTableValueType {
	return C.uiTableValueGetType(v)
}

// uiNewTableValueString() returns a new uiTableValue that contains
// str. str is copied; you do not need to keep it alive after
// uiNewTableValueString() returns.
pub fn C.uiNewTableValueString(str &i8) &C.uiTableValue

pub fn ui_new_table_value_string(str &i8) &C.uiTableValue {
	return C.uiNewTableValueString(str)
}

// uiTableValueString() returns the string stored in v. The returned
// string is owned by v. It is an error to call this on a uiTableValue
// that does not hold a string.
pub fn C.uiTableValueString(v &C.uiTableValue) &i8

pub fn ui_table_value_string(v &C.uiTableValue) &i8 {
	return C.uiTableValueString(v)
}

// uiNewTableValueImage() returns a new uiTableValue that contains
// the given uiImage.
//
// Unlike other similar constructors, uiNewTableValueImage() does
// NOT copy the image. This is because images are comparatively
// larger than the other objects in question. Therefore, you MUST
// keep the image alive as long as the returned uiTableValue is alive.
// As a general rule, if libui calls a uiTableModelHandler method, the
// uiImage is safe to free once any of your code is once again
// executed.
pub fn C.uiNewTableValueImage(img &C.uiImage) &C.uiTableValue

pub fn ui_new_table_value_image(img &C.uiImage) &C.uiTableValue {
	return C.uiNewTableValueImage(img)
}

// uiTableValueImage() returns the uiImage stored in v. As these
// images are not owned by v, you should not assume anything
// about the lifetime of the image (unless you created the image,
// and thus control its lifetime). It is an error to call this on a
// uiTableValue that does not hold an image.
pub fn C.uiTableValueImage(v &C.uiTableValue) &C.uiImage

pub fn ui_table_value_image(v &C.uiTableValue) &C.uiImage {
	return C.uiTableValueImage(v)
}

// uiNewTableValueInt() returns a uiTableValue that stores the given
// int. This can be used both for boolean values (nonzero is true, as
// in C) or progresses (in which case the valid range is -1..100
// inclusive).
pub fn C.uiNewTableValueInt(i int) &C.uiTableValue

pub fn ui_new_table_value_int(i int) &C.uiTableValue {
	return C.uiNewTableValueInt(i)
}

// uiTableValueInt() returns the int stored in v. It is an error to call
// this on a uiTableValue that does not store an int.
pub fn C.uiTableValueInt(v &C.uiTableValue) int

pub fn ui_table_value_int(v &C.uiTableValue) int {
	return C.uiTableValueInt(v)
}

// uiNewTableValueColor() returns a uiTableValue that stores the
// given color.
pub fn C.uiNewTableValueColor(r f64, g f64, b f64, a f64) &C.uiTableValue

pub fn ui_new_table_value_color(r f64, g f64, b f64, a f64) &C.uiTableValue {
	return C.uiNewTableValueColor(r, g, b, a)
}

// uiTableValueColor() returns the color stored in v. It is an error to
// call this on a uiTableValue that does not store a color.
// TODO define whether all this, for both uiTableValue and uiAttribute, is undefined behavior or a caught error
pub fn C.uiTableValueColor(v &C.uiTableValue, r &f64, g &f64, b &f64, a &f64)

pub fn ui_table_value_color(v &C.uiTableValue, r &f64, g &f64, b &f64, a &f64) {
	C.uiTableValueColor(v, r, g, b, a)
}

// uiTableModel is an object that provides the data for a uiTable.
// This data is returned via methods you provide in the
// uiTableModelHandler struct.
//
// uiTableModel represents data using a table, but this table does
// not map directly to uiTable itself. Instead, you can have data
// columns which provide instructions for how to render a given
// uiTable's column â for instance, one model column can be used
// to give certain rows of a uiTable a different background color.
// Row numbers DO match with uiTable row numbers.
//
// Once created, the number and data types of columns of a
// uiTableModel cannot change.
//
// Row and column numbers start at 0. A uiTableModel can be
// associated with more than one uiTable at a time.
// uiTableModelHandler defines the methods that uiTableModel
// calls when it needs data. Once a uiTableModel is created, these
// methods cannot change.
// TODO validate ranges; validate types on each getter/setter call (? table columns only?)
@[typedef]
pub struct C.uiTableModelHandler {
	// NumColumns returns the number of model columns in the
	// uiTableModel. This value must remain constant through the
	// lifetime of the uiTableModel. This method is not guaranteed
	// to be called depending on the system.
	// TODO strongly check column numbers and types on all platforms so these clauses can go away
	numColumns fn (&C.uiTableModelHandler, &C.uiTableModel) int
	// ColumnType returns the value type of the data stored in
	// the given model column of the uiTableModel. The returned
	// values must remain constant through the lifetime of the
	// uiTableModel. This method is not guaranteed to be called
	// depending on the system.
	columnType fn (&C.uiTableModelHandler, &C.uiTableModel, int) &C.uiTableValueType
	// NumRows returns the number or rows in the uiTableModel.
	// This value must be non-negative.
	numRows fn (&C.uiTableModelHandler, &C.uiTableModel) int
	// CellValue returns a uiTableValue corresponding to the model
	// cell at (row, column). The type of the returned uiTableValue
	// must match column's value type. Under some circumstances,
	// NULL may be returned; refer to the various methods that add
	// columns to uiTable for details. Once returned, the uiTable
	// that calls CellValue will free the uiTableValue returned.
	cellValue fn (&C.uiTableModelHandler, &C.uiTableModel, int, int) &C.uiTableValue
	// SetCellValue changes the model cell value at (row, column)
	// in the uiTableModel. Within this function, either do nothing
	// to keep the current cell value or save the new cell value as
	// appropriate. After SetCellValue is called, the uiTable will
	// itself reload the table cell. Under certain conditions, the
	// uiTableValue passed in can be NULL; refer to the various
	// methods that add columns to uiTable for details. Once
	// returned, the uiTable that called SetCellValue will free the
	// uiTableValue passed in.
	setCellValue fn (&C.uiTableModelHandler, &C.uiTableModel, int, int, &C.uiTableValue)
}

// @role uiTableModel constructor
// uiNewTableModel() creates a new uiTableModel with the given
// handler methods.
pub fn C.uiNewTableModel(mh &C.uiTableModelHandler) &C.uiTableModel

pub fn ui_new_table_model(mh &C.uiTableModelHandler) &C.uiTableModel {
	return C.uiNewTableModel(mh)
}

// @role uiTableModel destructor
// uiFreeTableModel() frees the given table model. It is an error to
// free table models currently associated with a uiTable.
pub fn C.uiFreeTableModel(m &C.uiTableModel)

pub fn ui_free_table_model(m &C.uiTableModel) {
	C.uiFreeTableModel(m)
}

// uiTableModelRowInserted() tells any uiTable associated with m
// that a new row has been added to m at index index. You call
// this function when the number of rows in your model has
// changed; after calling it, NumRows() should returm the new row
// count.
pub fn C.uiTableModelRowInserted(m &C.uiTableModel, new_index int)

pub fn ui_table_model_row_inserted(m &C.uiTableModel, new_index int) {
	C.uiTableModelRowInserted(m, new_index)
}

// uiTableModelRowChanged() tells any uiTable associated with m
// that the data in the row at index has changed. You do not need to
// call this in your SetCellValue() handlers, but you do need to call
// this if your data changes at some other point.
pub fn C.uiTableModelRowChanged(m &C.uiTableModel, index int)

pub fn ui_table_model_row_changed(m &C.uiTableModel, index int) {
	C.uiTableModelRowChanged(m, index)
}

// uiTableModelRowDeleted() tells any uiTable associated with m
// that the row at index index has been deleted. You call this
// function when the number of rows in your model has changed;
// after calling it, NumRows() should returm the new row
// count.
// TODO for this and Inserted: make sure the "after" part is right; clarify if it's after returning or after calling
pub fn C.uiTableModelRowDeleted(m &C.uiTableModel, old_index int)

pub fn ui_table_model_row_deleted(m &C.uiTableModel, old_index int) {
	C.uiTableModelRowDeleted(m, old_index)
}

// TODO reordering/moving
// uiTableModelColumnNeverEditable and
// uiTableModelColumnAlwaysEditable are the value of an editable
// model column parameter to one of the uiTable create column
// functions; if used, that jparticular uiTable colum is not editable
// by the user and always editable by the user, respectively.
// uiTableTextColumnOptionalParams are the optional parameters
// that control the appearance of the text column of a uiTable.
// uiTableParams defines the parameters passed to uiNewTable().
@[typedef]
pub struct C.uiTableTextColumnOptionalParams {
	// ColorModelColumn is the model column containing the
	// text color of this uiTable column's text, or -1 to use the
	// default color.
	//
	// If CellValue() for this column for any cell returns NULL, that
	// cell will also use the default text color.
	colorModelColumn int
}

@[typedef]
pub struct C.uiTableParams {
	// Model is the uiTableModel to use for this uiTable.
	// This parameter cannot be NULL.
	model &C.uiTableModel
	// RowBackgroundColorModelColumn is a model column
	// number that defines the background color used for the
	// entire row in the uiTable, or -1 to use the default color for
	// all rows.
	//
	// If CellValue() for this column for any row returns NULL, that
	// row will also use the default background color.
	rowBackgroundColorModelColumn int
}

// uiTable is a uiControl that shows tabular data, allowing users to
// manipulate rows of such data at a time.
// uiTableAppendTextColumn() appends a text column to t.
// name is displayed in the table header.
// textModelColumn is where the text comes from.
// If a row is editable according to textEditableModelColumn,
// SetCellValue() is called with textModelColumn as the column.
pub fn C.uiTableAppendTextColumn(l &C.uiTable, name &i8, text_model_column int, text_editable_model_column int, text_params &C.uiTableTextColumnOptionalParams)

pub fn ui_table_append_text_column(l &C.uiTable, name &i8, text_model_column int, text_editable_model_column int, text_params &C.uiTableTextColumnOptionalParams) {
	C.uiTableAppendTextColumn(l, name, text_model_column, text_editable_model_column,
		text_params)
}

// uiTableAppendImageColumn() appends an image column to t.
// Images are drawn at icon size, appropriate to the pixel density
// of the screen showing the uiTable.
pub fn C.uiTableAppendImageColumn(l &C.uiTable, name &i8, image_model_column int)

pub fn ui_table_append_image_column(l &C.uiTable, name &i8, image_model_column int) {
	C.uiTableAppendImageColumn(l, name, image_model_column)
}

// uiTableAppendImageTextColumn() appends a column to t that
// shows both an image and text.
pub fn C.uiTableAppendImageTextColumn(l &C.uiTable, name &i8, image_model_column int, text_model_column int, text_editable_model_column int, text_params &C.uiTableTextColumnOptionalParams)

pub fn ui_table_append_image_text_column(l &C.uiTable, name &i8, image_model_column int, text_model_column int, text_editable_model_column int, text_params &C.uiTableTextColumnOptionalParams) {
	C.uiTableAppendImageTextColumn(l, name, image_model_column, text_model_column, text_editable_model_column,
		text_params)
}

// uiTableAppendCheckboxColumn appends a column to t that
// contains a checkbox that the user can interact with (assuming the
// checkbox is editable). SetCellValue() will be called with
// checkboxModelColumn as the column in this case.
pub fn C.uiTableAppendCheckboxColumn(l &C.uiTable, name &i8, checkbox_model_column int, checkbox_editable_model_column int)

pub fn ui_table_append_checkbox_column(l &C.uiTable, name &i8, checkbox_model_column int, checkbox_editable_model_column int) {
	C.uiTableAppendCheckboxColumn(l, name, checkbox_model_column, checkbox_editable_model_column)
}

// uiTableAppendCheckboxTextColumn() appends a column to t
// that contains both a checkbox and text.
pub fn C.uiTableAppendCheckboxTextColumn(l &C.uiTable, name &i8, checkbox_model_column int, checkbox_editable_model_column int, text_model_column int, text_editable_model_column int, text_params &C.uiTableTextColumnOptionalParams)

pub fn ui_table_append_checkbox_text_column(l &C.uiTable, name &i8, checkbox_model_column int, checkbox_editable_model_column int, text_model_column int, text_editable_model_column int, text_params &C.uiTableTextColumnOptionalParams) {
	C.uiTableAppendCheckboxTextColumn(l, name, checkbox_model_column, checkbox_editable_model_column,
		text_model_column, text_editable_model_column, text_params)
}

// uiTableAppendProgressBarColumn() appends a column to t
// that displays a progress bar. These columns work like
// uiProgressBar: a cell value of 0..100 displays that percentage, and
// a cell value of -1 displays an indeterminate progress bar.
pub fn C.uiTableAppendProgressBarColumn(l &C.uiTable, name &i8, progress_model_column int)

pub fn ui_table_append_progress_bar_column(l &C.uiTable, name &i8, progress_model_column int) {
	C.uiTableAppendProgressBarColumn(l, name, progress_model_column)
}

// uiTableAppendButtonColumn() appends a column to t
// that shows a button that the user can click on. When the user
// does click on the button, SetCellValue() is called with a NULL
// value and buttonModelColumn as the column.
// CellValue() on buttonModelColumn should return the text to show
// in the button.
pub fn C.uiTableAppendButtonColumn(l &C.uiTable, name &i8, button_model_column int, button_clickable_model_column int)

pub fn ui_table_append_button_column(l &C.uiTable, name &i8, button_model_column int, button_clickable_model_column int) {
	C.uiTableAppendButtonColumn(l, name, button_model_column, button_clickable_model_column)
}

// uiNewTable() creates a new uiTable with the specified parameters.
pub fn C.uiNewTable(params &C.uiTableParams) &C.uiTable

pub fn ui_new_table(params &C.uiTableParams) &C.uiTable {
	return C.uiNewTable(params)
}

// #endif
