cd /Users/mak/Desktop/TAL/ProgrammationEtProjetEncadré/Fichiers

ANNEE=$1
TYPE=$2 
echo "pour l'année $ANNEE" > sortie.txt
grep '$TYPE' $ANNEE*.ann | wc -l >> sortie.txt
