#!/usr/bin/bash
# traitement de texte pendant le Cours 12 Octobre
cd /Users/mak/Desktop/TAL Education/Programmation et projet encadré/lecon 2 et 3/PPE/Fichiers
echo "pour l'année 2016" > sortie.txt
grep 'Location' 2016*.ann | wc -l >> sortie.txt
echo "pour l'année 2017" >> sortie.txt
grep 'Location' 2017*.ann | wc -l >> sortie.txt
echo "pour l'année 2018" >> sortie.txt
grep 'Location' 2018*.ann | wc -l >> sortie.txt




