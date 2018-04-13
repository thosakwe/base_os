#include <stdio.h>
#include "runtime/runtime.h"

void kernel_main(void)
{
    terminal_initialize();
    terminal_writestring("Hello, world!");
}