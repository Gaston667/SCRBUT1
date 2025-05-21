// disBonjout.s — version ARM64 (AArch64)

// === SECTION DES DONNÉES ===
// On définit ici le message à afficher, comme une suite de caractères ASCII.
// Le \n (code 10 en ASCII) sert à aller à la ligne à la fin du message.
.section .data
message:
    .ascii "Mon premier programe en assembleur!\n"    // Chaîne de caractères à afficher

// === SECTION DU CODE ===
// Partie principale contenant le code exécutable
.section .text
.global _start                // On déclare le point d’entrée du programme

_start:
    // --- APPEL SYSTÈME : write ---
    // Objectif : écrire notre message dans le terminal (stdout)

    mov     x8, #64           // Numéro de l'appel système "write" (64 sur ARM64)
    mov     x0, #1            // Premier argument : 1 = sortie standard (stdout)
    ldr     x1, =message      // Deuxième argument : adresse du message à afficher
    mov     x2, #36           // Troisième argument : longueur du message (26 caractères)
    svc     #0                // Exécute l'appel système (fait appel au noyau Linux)

    // --- APPEL SYSTÈME : exit ---
    // Objectif : terminer proprement le programme avec un code de sortie 0

    mov     x8, #93           // Numéro de l'appel système "exit" (93 sur ARM64)
    mov     x0, #0            // Code de retour du programme : 0 (succès)
    svc     #0                // Exécute l'appel système pour quitter le programme
