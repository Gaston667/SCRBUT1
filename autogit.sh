#!/bin/bash
#
# autoGit.sh : Script pour automatiser git add, commit, push, pull et status
#
# Usage : ./autoGit.sh <option> [<dossier_git>] "<message_commit>"
#

# Fonction pour vérifier si le répertoire est un dépôt Git valide
function verif() {
    # Vérifie si le répertoire courant ou spécifié est un dépôt Git
    if [ ! -d "$REPO_DIR/.git" ]; then
        echo "Erreur : '$REPO_DIR' n'est pas un dépôt Git valide."
        exit 1
    fi
}

# Fonction pour se placer dans le répertoire du dépôt Git
function se_placer_dans_repertoire() {
    if [[ -z "$REPO_DIR" ]]; then
        # Si aucun répertoire n'est spécifié, vérifier si on est déjà à la racine d'un dépôt Git
        if [ -d "$CURRENT_DIR/.git" ]; then
            echo "Vous êtes déjà dans la racine du dépôt Git : $CURRENT_DIR"
        else
            echo "Erreur : Vous devez spécifier un répertoire Git valide."
            exit 1
        fi
    else
        # Vérifie si le répertoire est un dépôt Git valide
        verif
        echo "je fais un cd $REPO_DIR pour me placer dans le répertoire Git valide."
        # Si un répertoire est spécifié, s'y déplacer
        cd "$REPO_DIR" || { echo "Erreur : Répertoire inexistant ou inaccessible."; exit 1; }
    fi
}

# Fonction pour afficher l'aide
function show_help() {
    echo "  Usage : $0 <option> [<dossier_git>] \"<message_commit>\""
    echo ""
    echo "  Ce script effectue des commandes Git telles que commit, push, pull et status."
    echo ""
    echo "  Options disponibles :"
    echo "      cp   Effectue un git add, commit et push avec le message spécifié."
    echo "      u    Effectue un git pull pour récupérer les dernières modifications."
    echo "      s    Affiche l'état du dépôt Git (git status)."
    echo ""
    echo "  Notes :"
    echo "  - Si vous exécutez ce script dans la racine d'un dépôt Git, le paramètre <dossier_git> est facultatif."
    echo "  - Si vous n'êtes pas dans un dépôt Git, le paramètre <dossier_git> est obligatoire."
    echo "  - Avant d'utiliser ce script, assurez-vous que votre authentification Git est configurée."
    echo "  "
    echo "  Exemples :"
    echo "    $0 cp /chemin/vers/repertoire \"Mon message de commit\""
    echo "    $0 cp \"Mon message de commit\" (si vous êtes déjà dans la racine du dépôt)"
    echo "    $0 u"
    echo "    $0 s"
    echo ""
    echo "  Pour configurer l'authentification Git (nécessaire pour les commandes 'push' et 'pull') :"
    echo ""
    echo "  1. Configurez le gestionnaire d'identifiants Git pour mémoriser vos informations :"
    echo "     git config --global credential.helper store"
    echo ""
    echo "  2. Lors de la première utilisation de 'git push' ou 'git pull', Git demandera :"
    echo "     - Votre nom d'utilisateur (username)."
    echo "     - Votre mot de passe ou token d'accès personnel (PAT) si vous utilisez GitHub ou GitLab."
    echo ""
    echo "  3. Si vous utilisez GitHub ou GitLab : (Pas de mise a jour dispo pour le moment)"
    echo "     - Créez un PAT (Personal Access Token) dans vos paramètres utilisateur."
    echo "     - Utilisez ce token comme mot de passe lors de la demande."
    echo ""
    echo "  4. Une fois configuré, vos informations d'identification seront mémorisées."
    echo ""
    echo ""
    echo "  Pour rendre ce script exécutable globalement :"
    echo ""
    echo "  1. Rendre le script exécutable :"
    echo "     chmod +x $0"
    echo ""
    echo "  2. Déplacer le script dans un répertoire inclus dans le PATH :"
    echo "     sudo mv $0 /usr/local/bin/"
    echo "     noublier pas de le renomer 'g' ca vous evitera de faire ./autoGit.sh a chaque fois"
    echo ""
    echo "  Une fois ces étapes terminées, vous pouvez exécuter ce script en tapant simplement :"
    echo "     'g <option> [<dossier_git>] \"<message_commit>\"'"
    exit 0
}

# Fonction pour faire un commit et un push
function commit_push() {

    # Se placer dans le répertoire du dépôt, si nécessaire
    se_placer_dans_repertoire

    if [[ -z "$COMMIT_MSG" ]]; then
        echo "Erreur : Vous devez spécifier un message de commit."
        exit 1
    fi

    # Ajouter tous les fichiers modifiés
    git add .

    # Effectuer le commit avec le message spécifié
    git commit -m "$COMMIT_MSG"

    # Pousser les changements vers le dépôt distant
    git push
}

# Fonction pour récupérer les dernières modifications (pull)
function pull() {

    # Se placer dans le répertoire du dépôt, si nécessaire
    se_placer_dans_repertoire

    # Effectuer le pull
    git pull
}

# Fonction pour afficher l'état du dépôt Git
function git_status() {
    # Vérifie si le répertoire est un dépôt Git valide
    verif

    # Se placer dans le répertoire du dépôt, si nécessaire
    se_placer_dans_repertoire

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



