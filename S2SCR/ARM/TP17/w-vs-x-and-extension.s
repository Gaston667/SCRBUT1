/*
Lines enclosed here are comments
A small program: prints "Hello World!"
*/

// From // to the end of this line is a comment: next are directives to the assembler
    .equ SYS_EXIT, 93

    .data // tells assembler to assemble the following in the data section
int:.quad
int32:.word
    .temp

    // in the text (code) section
    .globl _start // _start is there where the program starts,
                  // .globl makes it visible to the linker

_start:
    adr x1,int
    ldr x0

    haha revoir les overflow pour le prochain td
       

mov x0, #0     // in x0 put the value you want to exit with
mov w8,#SYS_EXIT
svc #0
.end