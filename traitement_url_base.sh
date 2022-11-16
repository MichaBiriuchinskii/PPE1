#!/usr/bin/env bash

#===============================================================================
# VOUS DEVEZ MODIFIER CE BLOC DE COMMENTAIRES.
# Ici, on décrit le comportement du programme.
# Indiquez, entre autres, comment on lance le programme et quels sont
# les paramètres.
# La forme est indicative, sentez-vous libres d'en changer !
# Notamment pour quelque chose de plus léger, il n'y a pas de norme en bash.
#===============================================================================
# !!!!!!
# ici on doit vérifier que nos deux paramètres existent, sinon on ferme!
# !!!!!!

if [ $# -ne 2 ] #si le nombre d'éléments n'est pas égale à 2, on exit
then 
		echo "il faut 2 paramètres"
		echo "Syntaxe : bash traitement_url_base.sh nom_fichier_URL nom_fichier_HTML"
		exit
fi

fichier_urls=$1 # le fichier d'URL en entrée
fichier_tableau=$2 # le fichier HTML en sortie

echo 	"<html>
	<head>
		<meta charset=\"utf-8\" />
		<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css\">
		<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
		<title>Tableau des URLS</title>
	</head>
	<body>
		<h1 class=\"title\">Tableau des URLs</h1>
		<table class=\"table is-bordered is-striped is-narrow is-hoverable is-fullwidth\">
			<thead><tr><th>Numéro</th><th>code HTTP</th><th>URL</th></tr></thead>" > $fichier_tableau 

lineno=1;

while read -r line;
do
	URL=$line;
	HTTP=$(curl --head $URL | egrep HTTP | cut -d " " -f 2)
	echo "<tr><td>$lineno</td><td>$HTTP</td><td>$URL</td></tr>" >> $fichier_tableau 
	lineno=$((lineno+1));
done  < $fichier_urls
	

# modifier la ligne suivante pour créer effectivement du HTML
#echo "Je dois devenir du code HTML à partir de la question 3" > $fichier_tableau

echo "
</table>
</body>
</html>" >> $fichier_tableau

