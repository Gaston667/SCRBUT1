    .equ SYS_EXIT, 93

    .data // tells assembler to assemble the following in the data section
    int1:.quad 2 //Pour les addr en 64 bits
    int2:.quad -3 //Pour les addr en 64 bits
    .text

    // in the text (code) section
    .globl _start // _start is there where the program starts,
                  // .globl makes it visible to the linker

_start:
    adr x3,int1
    ldr x0, [x3] 

    ldr x3, =int2       
    ldr x1, [x3]

    add x2,x0,x1  


       

mov x0, #0     // in x0 put the value you want to exit with
mov w8,#SYS_EXIT
svc #0
.end



