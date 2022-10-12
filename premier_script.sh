#!/usr/bin/bash
# traitement de texte pendant le Cours 12 Octobre
echo 'pour l'année 20!6' > sortie.txt
grep 'Location' 2016*.ann | wc -l >> sortie.txt
echo 'pour l'année 2017' >> sortie.txt
grep 'Location' 2017*.ann | wc -l >> sortie.txt
echo 'pour l'année 2018' >> sortie.txt
grep 'Location' 2018*.ann | wc -l >> sortie.txt




