#!/bin/bash
#
# autoGit.sh : Script pour automatiser git add, commit, push, pull et status
#
# Usage : ./autoGit.sh <option> [<dossier_git>] "<message_commit>"
#

# Fonction pour vérifier si le répertoire est un dépôt Git valide
function verif() {
    # Vérifie si le répertoire courant ou spécifié est un dépôt Git
    if [[ $# -gt 2 ]]; then
        if [ ! -d "$REPO_DIR/.git" ]; then
        echo "Erreur : '$REPO_DIR' n'est pas un depot Git valide."
        exit 1
        echo "lolaea"
        fi
    fi
    echo "lolaea"
}

# Fonction pour se placer dans le répertoire du dépôt Git
function se_placer_dans_repertoire() {
    if [[ -z "$REPO_DIR" ]]; then
        # Si aucun répertoire n'est spécifié, vérifier si on est déjà à la racine d'un dépôt Git
        if [ -d "$CURRENT_DIR/.git" ]; then
            echo "Vous etes deja dans la racine du depot Git : $CURRENT_DIR"
        else
            echo "Erreur : Vous devez specifier un repertoire Git valide."
        fi

        # Vérifie si le répertoire est un dépôt Git valide
        verif
        echo "lol"

        echo "je fais un cd $REPO_DIR pour me placer dans le repertoire Git valide."
        # Si un répertoire est spécifié, s'y déplacer
        cd "$REPO_DIR" || { echo "Erreur : Repertoire inexistant ou inaccessible."; exit 1; }
    fi
    verif

    echo "je fais un cd $REPO_DIR pour me placer dans le repertoire Git valide."
    # Si un répertoire est spécifié, s'y déplacer
    cd "$REPO_DIR" || { echo "Erreur : Repertoire inexistant ou inaccessible."; exit 1; }
}

# Fonction pour afficher l'aide
function show_help() {
    echo "  Usage : $0 <option> [<dossier_git>] \"<message_commit>\""
    echo ""
    echo "  Ce script effectue des commandes Git telles que commit, push, pull et status."
    echo ""
    echo "  Options disponibles :"
    echo "      cp   Effectue un git add, commit et push avec le message specifie."
    echo "      u    Effectue un git pull pour recuperer les dernieres modifications."
    echo "      s    Affiche l'etat du depot Git (git status)."
    echo ""
    echo "  Notes :"
    echo "  - Si vous executez ce script dans la racine d'un depot Git, le parametre <dossier_git> est facultatif."
    echo "  - Si vous n'etes pas dans un depot Git, le parametre <dossier_git> est obligatoire."
    echo "  - Avant d'utiliser ce script, assurez-vous que votre authentification Git est configuree."
    echo "  "
    echo "  Exemples :"
    echo "    $0 cp /chemin/vers/repertoire \"Mon message de commit\""
    echo "    $0 cp \"Mon message de commit\" (si vous etes deja dans la racine du depot)"
    echo "    $0 u"
    echo "    $0 s"
    echo ""
    echo "  Pour configurer l'authentification Git (necessaire pour les commandes 'push' et 'pull') :"
    echo ""
    echo "  1. Configurez le gestionnaire d'identifiants Git pour memoriser vos informations :"
    echo "     git config --global credential.helper store"
    echo ""
    echo "  2. Lors de la premiere utilisation de 'git push' ou 'git pull', Git demandera :"
    echo "     - Votre nom d'utilisateur (username)."
    echo "     - Votre mot de passe ou token d'acces personnel (PAT) si vous utilisez GitHub ou GitLab."
    echo ""
    echo "  3. Si vous utilisez GitHub ou GitLab : (Pas de mise a jour dispo pour le moment)"
    echo "     - Creez un PAT (Personal Access Token) dans vos parametres utilisateur."
    echo "     - Utilisez ce token comme mot de passe lors de la demande."
    echo ""
    echo "  4. Une fois configure, vos informations d'identification seront memorisees."
    echo ""
    echo ""
    echo "  Pour rendre ce script executable globalement :"
    echo ""
    echo "  1. Rendre le script executable :"
    echo "     chmod +x $0"
    echo ""
    echo "  2. Deplacer le script dans un repertoire inclus dans le PATH :"
    echo "     sudo mv $0 /usr/local/bin/"
    echo "     noublier pas de le renomer 'g' ca vous evitera de faire ./autoGit.sh a chaque fois"
    echo ""
    echo "  Une fois ces etapes terminees, vous pouvez executer ce script en tapant simplement :"
    echo "     'g <option> [<dossier_git>] \"<message_commit>\"'"
    exit 0
}

# Fonction pour faire un commit et un push
function commit_push() {

    # Se placer dans le répertoire du dépôt, si nécessaire
    se_placer_dans_repertoire

    if [[ -z "$COMMIT_MSG" ]]; then
        echo "Erreur : Vous devez specifier un message de commit."
        exit 1
    fi

    # Ajouter tous les fichiers modifiés
    echo "------------------------------------------------------------"
    echo ""
    echo "Je capture les modification avec add"
    git add .
    echo "------------------------------------------------------------"
    echo ""
    echo "Je creer un paquet des modifications et j'etiquette avec: $COMMIT_MSG"
    echo ""
    # Effectuer le commit avec le message spécifié
    git commit -m "$COMMIT_MSG"
    echo "------------------------------------------------------------"
    echo "J'envoie le paquet sur le serveur."
    echo ""
    # Pousser les changements vers le dépôt distant
    git push
}

# Fonction pour récupérer les dernières modifications (pull)
function pull() {

    # Se placer dans le répertoire du dépôt, si nécessaire
    se_placer_dans_repertoire


    echo "je demande au serveur de m'envoyer les paquet pour mettre a jour mes fichiers"
    # Effectuer le pull
    git pull
}

# Fonction pour afficher l'état du dépôt Git
function git_status() {
    # Vérifie si le répertoire est un dépôt Git valide  
    verif

    # Se placer dans le répertoire du dépôt, si nécessaire
    se_placer_dans_repertoire

    echo "Voici l'etat actuelle de votre depot local git"
    # Afficher l'état du dépôt
    git status
}

# Définir l'option, le répertoire du dépôt et le message de commit
OPTION="$1"
CURRENT_DIR=$(pwd)
if [[ $# -gt 2 ]]; then
    REPO_DIR="$2"
    COMMIT_MSG="$3"
elif [[ $# -le 2 ]]; then
    COMMIT_MSG="$2"
fi

# Vérification de l'option d'aide
if [[ "$1" == "h" ]] || [[ "$1" == "help" ]]; then
    show_help
fi

# Vérification et traitement des options
if [[ "$OPTION" == "cp" ]]; then
    # Exécuter la fonction commit_push
    commit_push
elif [[ "$OPTION" == "u" ]]; then
    # Exécuter la fonction pull
    pull
elif [[ "$OPTION" == "s" ]]; then
    # Exécuter la fonction git_status
    git_status
else
    # Afficher l'aide pour une option inconnue
    echo "Option inconnue : $OPTION"
    echo "utiliser l'option h ou help pour en savoir plus. Attention ne pas utiliser de tiret(-h ou -help)"
    #show_help
fi



