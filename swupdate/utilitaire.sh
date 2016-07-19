#!/bin/sh
# utilitaire.sh - A shell script to create automatically sw-description
# And to configure sw-description generator 

CONFIG_FILE="swupdate_config"

# Configure sw-description generator 
configuration () {

  OPTIONS=(1 "Dossier de destination"
         2 "Dossier source"
         3 "Chemin vers la clé privée" 
         4 "Chemin vers la clé publique"
         5 "Chemin vers le fichier de configuration")

  CHOICE=$(dialog --clear \
                --backtitle "Configuration de l'outil de mise à jour" \
                --title "Configuration" \
                --menu "" \
                100 100 100 \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

  clear

  DESTINATION_DIR=$1
  SOURCE_DIR=$2
  PRIVATE_KEY_PATH=$3
  PUBLIC_KEY_PATH=$4
  CONFIG_FILE=$5

  case $CHOICE in
        1)
            
            DESTINATION_DIR=$(dialog --title "Dossier de destination" \
            --backtitle "Configuration" \
            --inputbox "Entrez le chemin de destination" 8 60 \
             2>&1 1>&3 ) 
            ;;
        2)
            SOURCE_DIR=$(dialog --title "Dossier source" \
            --backtitle "Configuration " \
            --inputbox "Entrez le chemin source" 8 60 \
            2>&1 1>&3 )
            ;;
            
        3)
            PRIVATE_KEY_PATH=$(dialog --title "Chemin vers la clé privée" \
            --backtitle "Configuration" \
            --inputbox "Entrez le chemin de la clé privée" 8 60 \
            2>&1 1>&3)
            ;;
        4)
            PUBLIC_KEY_PATH=$(dialog --title "Chemin vers la clé publique" \
            --backtitle "Configuration" \
            --inputbox "Entrez le chemin de la clé publique" 8 60 \
            2>&1 1>&3)
            ;;
        5)
            CONFIG_FILE=$(dialog --title "Chemin vers le fichier de configuration" \
            --backtitle "Configuration" \
            --inputbox "Entrez le chemin du fichier de configuration du système de mise à jour" 8 60 \
            2>&1 1>&3 )
            ;;
  esac
     
  write_config $DESTINATION_DIR $SOURCE_DIR $PRIVATE_KEY_PATH $PUBLIC_KEY_PATH $CONFIG_FILE

  }

init_variables () {

  DESTINATION_DIR=$(grep destination $CONFIG_FILE | cut -d= -f2) 
  SOURCE_DIR=$(grep \source $CONFIG_FILE | cut -d= -f2) 
  PRIVATE_KEY_PATH=$(grep privée $CONFIG_FILE | cut -d= -f2) 
  PUBLIC_KEY_PATH=$(grep publique $CONFIG_FILE | cut -d= -f2) 
  CONFIG_FILE=$(grep configuration $CONFIG_FILE | cut -d= -f2)
  
  echo $DESTINATION_DIR $SOURCE_DIR $PRIVATE_KEY_PATH $PUBLIC_KEY_PATH $CONFIG_FILE
}

# Write config variables in sw-description generator config file
write_config () {
echo $1 $2 $3 $4 $5

echo -e " \
  Dossier de destination=$1 \n \
  Dossier source=$2 \n \
  Chemin vers la clé privée=$3 \n \
  Chemin vers la clé publique=$4 \n \
  Chemin vers le fichier de configuration=$5 " > $5
}


main_window () {

  OPTIONS=(1 "Création d'une mise à jour"
         2 "Configuration")


  CHOICE=$(dialog --clear \
                --backtitle "Générateur d'archive de  mise à jour" \
                --title "Générateur d'archive de mise à jour" \
                --menu "" \
                15 40 4 \
                "${OPTIONS[@]}"\
                2>&1 >/dev/tty)
  clear
  case $CHOICE in
        1)
          creation_maj
            ;;
        2)
          configuration $1 $2 $3 $4 $5 
            ;;
  esac
}

exec 3>&1
read DESTINATION_DIR SOURCE_DIR PRIVATE_KEY_PATH PUBLIC_KEY_PATH CONFIG_FILE <<< $(init_variables) 
echo  "recup $DESTINATION_DIR $SOURCE_DIR $PRIVATE_KEY_PATH $PUBLIC_KEY_PATH $CONFIG_FILE "
main_window $DESTINATION_DIR $SOURCE_DIR $PRIVATE_KEY_PATH $PUBLIC_KEY_PATH $CONFIG_FILE
exec 3>&-
 

