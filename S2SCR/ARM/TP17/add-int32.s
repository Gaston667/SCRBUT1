    .equ SYS_EXIT, 93

    .data // tells assembler to assemble the following in the data section
    int1:.word 2 //Pour les addr en 64 bits
    int2:.word -3 //Pour les addr en 64 bits
    .text

    // in the text (code) section
    .globl _start // _start is there where the program starts,
                  // .globl makes it visible to the linker

_start:
    adr x3,int1
    ldr w0,[x3] 

    adr x3,int2       
    ldr w1,[x3]

    adds w2,w0,w1  
    mrs x3,nzcv

mov x0, #0     // in x0 put the value you want to exit with
mov w8,#SYS_EXIT
svc #0
.end

