#!/bin/bash
#Script designed for use on a mac by french-speaking colleagues at work.

#This script lists images in folders and subfolders
# collects the Height, Width and file size in a CSV.
# Note: CSV in UTF-8 but MS Excel might not detect encoding properly

#Morgan Aasdam - 2017/04/06
#Public Domain

#enter CWD
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#présentation
echo "Bonjour"
echo "Je bosse dans le dossier $( dirname "${BASH_SOURCE[0]}" )"
echo "Il y a $(find . \( ! -regex '.*/\..*' \) -type f | wc -l) fichiers dans les dossiers."
echo "J'ai trouvé $(find . \( ! -regex '.*/\..*' \)  -type f \( -name "*.jpg" -o -name "*.gif" -o -name "*.png" -o -name "*.jpeg" -o -name "*.tif" -o -name "*.tiff" -o -name "*.bmp" -o -name "*.JPG" -o -name "*.GIF" -o -name "*.PNG" -o -name "*.JPEG" -o -name "*.TIF" -o -name "*.TIFF" -o -name "*.BMP" \) | wc -l) fichiers image."
echo
echo
echo "C'est bon, j'y vais?"
echo "Entrée pour continuer CTRL+C pour terminer"
read choice

#au boulot
letmework() {
echo "Dossier;Fichier;Largeur;Hauteur;Poids en Ko;"
find . \( ! -regex '.*/\..*' \)  -type f \( -name "*.jpg" -o -name "*.gif" -o -name "*.png" -o -name "*.jpeg" -o -name "*.tif" -o -name "*.tiff" -o -name "*.bmp" -o -name "*.JPG" -o -name "*.GIF" -o -name "*.PNG" -o -name "*.JPEG" -o -name "*.TIF" -o -name "*.TIFF" -o -name "*.BMP" \) -print0 | 
    while IFS= read -r -d $'\0' line; do 
        echo "$(dirname "$line");$line;$(sips -g pixelWidth "$line"  | awk '/pixelWidth:/{print $2}');$(sips -g pixelHeight "$line"  | awk '/pixelHeight:/{print $2}');$( du -k "$line" | awk -F " " {'print $1'})"
    done
}

letmework . > listingDuDossier.csv

#done
echo "Fini!"

#open the file
open listingDuDossier.csv