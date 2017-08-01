ENTRY(_start)
SECTIONS
{
 . = 0x0;
 .text : {
    irq.o (.text);
    handler.o (.text);
 }
 . = . + 0x1000; /* 4kB of stack memory */
 stack_top = .;
}
