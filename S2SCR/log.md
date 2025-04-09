 1. Introduction – Mise en contexte

Dans cet exercice, on travaille avec l'architecture ARM 64 bits (AArch64), où les registres ont deux formes :

    Xn : registre 64 bits

    Wn : les 32 bits bas du registre Xn

L’objectif est de comprendre le comportement des instructions ldr (load register) lorsqu’on charge des données de 32 bits ou 64 bits dans les registres, et ce que cela implique sur le contenu total de Xn. On va voir aussi la différence entre extension signée et non signée (important quand on fait des opérations entre entiers de différentes tailles).
⚙️ 2. Explication et démonstration
🧾 Étapes dans le fichier w-vs-x-and-extension.s :

a) On place deux valeurs dans la section .data :

.data
int:      .quad 0x11223344aabbccdd    // 64 bits
int32:    .word 0x887766ee            // 32 bits

b) On les charge dans les registres :

.text
.global _start

_start:
    ldr x0, =int          // Adresse de int dans x0
    ldr x0, [x0]          // (*) Charge les 64 bits dans x0

    ldr x1, =int32        // Adresse de int32 dans x1
    ldr w0, [x1]          // (**) Charge 32 bits dans w0 (modifie seulement les 32 bits bas de x0)

🔍 Que fait-on avec GDB ?

    Avant (*), on met un breakpoint :
    break _start + offset_de_ligne

    On avance pas à pas avec si (step instruction)

    On observe le registre x0 avec info reg x0

💥 Le point important :

Quand on fait ldr w0, [...], cela charge 32 bits dans w0, mais cela met à zéro les 32 bits hauts de x0.

📌 Exemple :

    Avant : x0 = 0x11223344aabbccdd

    Après : w0 = 0x887766ee → donc x0 = 0x00000000887766ee

Donc : charger dans w0 modifie indirectement x0, mais avec une extension nulle sur la partie haute.
🧒🏽 3. Comme si tu avais 10 ans (ou 5 ans)

Imagine que x0 est une boîte à 64 blocs, et w0 n’en occupe que 32.
Quand tu mets une valeur dans w0, tu remplis seulement la moitié basse de la boîte, et tu vides l’autre moitié (elle devient toute propre = zéro).
C’est comme si tu dessinais dans le bas d’une feuille, et tu effaçais tout ce qu’il y avait en haut.

Tu veux que je t’explique aussi la différence entre extension signée et non signée dans ce même fichier ?