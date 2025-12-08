#include <string.h>
#include <stdlib.h>
#include "../../ui.h"

int onClosing(uiWindow *w, void *data)
{
	uiQuit();
	return 1;
}

int main(void)
{
	uiInitOptions o;
	uiWindow *w;

	memset(&o, 0, sizeof (uiInitOptions));
	if (uiInit(&o) != NULL){
		abort();
    }

	w = uiNewWindow("Hello", 320, 240, 0);
	uiWindowOnClosing(w, onClosing, NULL);
	uiControlShow(uiControl(w));
	uiMain();
	return 0;
}
