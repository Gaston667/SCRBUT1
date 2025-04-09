/*
Lines enclosed here are comments
A small program: prints "Hello World!"
*/

// From // to the end of this line is a comment: next are directives to the assembler
    .equ SYS_EXIT, 93
    .equ SYS_WRITE, 64

    .data // tells assembler to assemble the following in the data section
    int:.quad 0x11223344aabbccdd  //Pour les addr en 64 bits
    int32:.word 0x887766ee  //Pour les addr en 32 bits
    .text

    // in the text (code) section
    .globl _start // _start is there where the program starts,
                  // .globl makes it visible to the linker

_start:
    adr x1,int
    ldr x0, [x1] // Charge les 64 bits nombre dans x0

    adr x1, int32 // Adresse de int32 dans x1  ou faire ldr x1,=int32
    ldr w0, [x1]          // (**) Charge 32 bits dans w0 (modifie seulement les 32 bits bas de x0)


       

mov x0, #0     // in x0 put the value you want to exit with
mov w8,#SYS_EXIT
svc #0
.end
// Faut toujours mettre un retour a la ligne sinon on obtient un warning