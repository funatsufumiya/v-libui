#pragma once

#include "ui.h"

uiControl* asUiControl(void* ptr){
    return (uiControl*) ptr;
}

// uiAreaHandler createUiAreaHandler() {
//     return uiAreaHandler{};
// }