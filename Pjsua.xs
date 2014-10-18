#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
MODULE = Pjsua PACKAGE = Pjsua

void
hello()
CODE:
	printf("This is a test!\n");
