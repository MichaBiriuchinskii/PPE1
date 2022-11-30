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


if [ $# -ne 2 ] #si le nombre d'éléments n'est pas égale à 2, on exit, прописываем условия программы
then 
		echo "il faut 2 paramètres"
		echo "Syntaxe : bash traitement_url_base.sh nom_fichier_URL nom_fichier_HTML"
		exit
fi
fichier_urls=$1 # le fichier d'URL en entrée
fichier_tableau=$2 # le fichier HTML en sortie

#здесь начинается создание сайта, прописывается условия для создания таблицы и её оформение
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
			<thead><tr><th>Numéro</th><th>code HTTP</th><th>URL</th><th>Encodage</th> <th>Dump Texte</th></tr></thead>" > $fichier_tableau # направляет сайт, удаляя содержимое предыдущее всего файла

lineno=1; #счетчик линий
#читаем линии из файла
#while read -r line;
#do
	#URL=$line;
	#HTTP=$(curl --head $URL | egrep HTTP | cut -d " " -f 2) #здесь определяем переменную, которая ищет начало в доке с урл "ХТТП" и обрезает с помощью пробела текст, берет второй элемент, который нужен (это статус сайта, работает или нет)
while read -r URL; do
	echo -e "\tURL : $URL";
	code=$(curl -ILs $URL | grep -e "^HTTP/" | grep -Eo "[0-9]{3}" | tail -n 1)
	charset=$(curl -ILs $URL | grep -Eo "charset=(\w|-)+" | cut -d= -f2)
	charset=$(echo $charset | tr "[a-z]" "[A-Z]") #здесь мы определяем для значения шарсет команду "переделай все маленькие буквы в большие, чтобы всезде UTF-8 были одного вида
	echo -e "\tcode : $code"; 
	
	if [[ ! $charset ]]
	then
			echo -e "\tencodage non détecté, on prendra UTF-8 par défaut.";
			charset="UTF-8";
	else
			echo -e "\tencodage : $charset";
	fi
	
	if [[ $code -eq 200 ]]
	then
			dump=$(lynx -dump -nolist -assume_charset=$charset -display_charset=$charset $URL)
			if [[ $charset -ne "UTF-8" && -n "$dump" ]]
			then
					dump=$(echo $dump | iconv -f $charset -t UTF-8//IGNORE)
			fi
	else
			echo -e "\tcode différent de 200 utilisation d'un dump vide"
			dump=""
			charset=""
	fi
	
	echo "<tr><td>$lineno</td><td>$code</td><td>$URL</td><td>$charset</td><td></td></tr>" >> $fichier_tableau #тут мы указываем, куда заносить всю инфу и отмечаем, что при каждой итерации не нужно удалять
	echo -e "\t--------------------------------"
	lineno=$((lineno+1));
	
done  < $fichier_urls

echo "</table>" >> $fichier_tableau
echo "</body></html>" >> $fichier_tableau
	
# modifier la ligne suivante pour créer effectivement du HTML
#echo "Je dois devenir du code HTML à partir de la question 3" > $fichier_tableau
