/*
Lines enclosed here are comments
A small program: prints "Hello World!"
*/

// From // to the end of this line is a comment: next are directives to the assembler
    .equ SYS_EXIT, 93
    .equ SYS_WRITE, 64

    .data // tells assembler to assemble the following in the data section

msg: .asciz "Hello World!\n" //msg retains the address of the string
    .text          // tells assembler to assemble the following

    // in the text (code) section
    .globl _start // _start is there where the program starts,
                  // .globl makes it visible to the linker

_start:
mov x0,#1             // value 1 is placed in register x0
adr x1,msg           // the address retained by label msg is placed in register x1
mov x2,#13
mov w8, #SYS_WRITE // svc must find the syscall number in w8
                  // and the syscall arguments in x0,x1,x2

svc #0          // invoke syscall: displays on the screen
mov x0, #0     // in x0 put the value you want to exit with
mov w8,#SYS_EXIT
svc #0
.end



