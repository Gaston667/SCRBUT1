# SCR

Les TP de SCR

###Les commande sont aussi dispo dans le fichier pdf

## **TP1 : Initiation à UNIX**

### **Découverte de l'environnement**

- **Utilisateur courant** :
    
    - `whoami` : Affiche le nom de l'utilisateur actuel.
    - `id` : Affiche l'ID de l'utilisateur et ses groupes.
- **Informations sur le système** :
    
    - `uname` : Affiche des informations sur le système (OS, noyau, machine).
    - `printenv HOME` : Affiche le chemin du répertoire personnel de l’utilisateur.
- **Lister les fichiers** :
    
    - `ls` : Affiche le contenu d’un répertoire.
    - `ls -l` : Affiche une liste détaillée des fichiers.
    - `ls -a` : Affiche tous les fichiers, y compris les fichiers cachés.
    - `man ls` : Affiche le manuel de la commande `ls`.

### **Navigation dans le système de fichiers**

- **Répertoire de travail actuel** :
    - `pwd` : Affiche le chemin du répertoire de travail actuel.
- **Changer de répertoire** :
    - `cd <chemin>` : Change de répertoire.
    - `cd` sans argument : Retourne au répertoire personnel.

### **Création et gestion de fichiers/répertoires**

- **Créer des répertoires et fichiers** :
    
    - `mkdir -p <chemin>` : Crée un répertoire et ses sous-répertoires.
    - `touch <nom_fichier>` : Crée un fichier vide.
- **Gestion des fichiers et répertoires** :
    
    - `cp` : Copie un fichier.
    - `mv` : Déplace ou renomme un fichier.
    - `rm` : Supprime un fichier ou répertoire.
    - **Exemple d'opérations** : Copier, déplacer, renommer des fichiers, et reconstituer une arborescence.

### **Définir des alias**

- **Alias** :
    - `alias <nom_alias>='<commande>'` : Crée un alias.
    - **Exemple** : `alias rm='rm -i'` pour demander confirmation avant chaque suppression.
    - **Configuration persistante** : Ajouter les alias dans `~/.bashrc` pour qu’ils soient actifs à chaque session.

---

## **TP2 : Lignes de commande, redirections et codes de sortie**

### **Codes de sortie**

- **Codes de sortie des commandes** :
    - **0** : Succès.
    - **Non zéro** : Échec, avec un code spécifique selon l’erreur.
    - `$?` : Affiche le code de sortie de la dernière commande.

### **Combinaisons de commandes**

- **Pipeline (`|`)** : Passe la sortie d’une commande en entrée d’une autre.
- **Séquences de commandes** :
    - `;` : Exécute les commandes en séquence, indépendamment du succès.
    - `&&` : Exécute la seconde commande seulement si la première réussit.
    - `||` : Exécute la seconde commande seulement si la première échoue.

### **Redirections des entrées/sorties**

- **Sortie standard** :
    
    - `>` : Redirige vers un fichier (écrase).
    - `>>` : Ajoute au fichier existant.
- **Sortie d'erreur** :
    
    - `2>` : Redirige les erreurs vers un fichier.
    - `2>>` : Ajoute les erreurs au fichier.
- **Combinaison des sorties** :
    
    - `2>&1` : Combine la sortie standard et la sortie d’erreur dans le même fichier.

---

## **TP3 : Représentation de texte et gestion d’encodage**

### **Affichage de texte et variables**

- **Commande `echo`** :
    
    - Affiche du texte.
    - `echo -n` : Affiche sans retour à la ligne.
- **Commande `read`** :
    
    - Affecte une entrée utilisateur à une variable : `read variable`.
    - `read -p "Message" variable` : Affiche un message avant la saisie.

### **Encodage et hexadécimal**

- **Commande `hexdump`** :
    - Affiche le contenu d’un fichier en hexadécimal pour vérifier l'encodage.
    - `hexdump -C <fichier>` : Affiche l’encodage UTF-8 d’un texte.

---

## **TP4 : Configuration de l’environnement et gestion des disques**

### **Disposition du clavier**

- **Configuration du clavier** :
    
    - `localectl status` : Affiche la disposition actuelle.
    - `localectl list-keymaps` : Liste les dispositions disponibles.
    - `loadkeys <disposition>` : Change la disposition du clavier pour la session.
- **Fichier de configuration** : `/etc/vconsole.conf` pour la disposition par défaut.
    

### **Partitionnement et montage des disques**

- **Commandes de gestion des disques** :
    
    - `lsblk` : Liste les périphériques de stockage et leurs partitions.
    - `mount` : Affiche les partitions montées.
    - `findmnt` : Affiche les systèmes de fichiers montés.
- **Fichiers de configuration pour le montage** :
    
    - `/etc/mtab` : Liste des systèmes de fichiers montés actuellement.
    - `/etc/fstab` : Définition des montages automatiques au démarrage.

### **Vérification de la connexion réseau**

- **Interfaces réseau** :
    
    - `ip link` : Liste les interfaces réseau.
    - `ip address` : Affiche les adresses IP.
    - `rfkill` : Vérifie si la carte Wi-Fi est bloquée.
- **Client DHCP** :
    
    - `ps aux | grep dhcpcd` : Vérifie si le client DHCP est actif.
    - `dhclient <interface>` : Lance le client DHCP pour l’interface spécifiée.

---

## **TP5 : Commandes liées au matériel**

### **Informations système et matériel**

- **Commande `man` avec mot-clé** :
    
    - `man -k <mot-clé>` : Recherche des commandes associées à un mot-clé.
- **Informations de configuration** :
    
    - `uname -r` : Affiche la version du noyau.
    - `/etc/hostname` : Contient le nom de la machine.
- **Processeur et mémoire** :
    
    - `lscpu` : Affiche des informations sur le processeur (cœurs, vitesse, vendeur).
    - `free -h` : Affiche la taille de la mémoire principale.
    - `lshw -C display` : Affiche la mémoire de la carte graphique.
- **Périphériques et pilotes** :
    
    - `lsusb` et `lspci` : Affichent les périphériques USB et PCI.
    - `lsmod` : Affiche les modules chargés, dont les pilotes.
- **Carte Ethernet** :
    
    - `lshw -C network` : Affiche les informations sur la carte réseau (vendeur, pilote).