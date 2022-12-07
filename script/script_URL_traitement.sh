#!/usr/bin/env bash

# в начале программы можно добавить условие "этот скрипт должен запускаться в racine и тут должны быть такие-то папки. 
#Если их нет - писать мол создайте правильную среду для скрипта


if [ $# -ne 2 ] #si le nombre d'éléments n'est pas égale à 2, on exit, прописываем условия программы
then 
		echo "il faut 2 paramètres"
		echo "Syntaxe : (1) script_URL_traitement.sh (2) nom_fichier_URL (3) nom_fichier_HTML"
		exit
fi
fichier_urls=$1 # le fichier d'URL en entrée
fichier_tableau=$2 # le fichier HTML en sortie

mot="(имм|эм)игр\w+" 

echo $fichier_urls;
basename=$(basename -s .txt $fichier_urls)
#basename -s удаляет путь, оставляя только конечное имя файла. Опция -s удаляет расширение (тж называется suffix)

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
			<thead><tr><th>code HTTP</th><th>URL</th><th>Encodage</th><th>Aspirations</th><th>Dump</th><th>Count</th><th>Occurences</th><th>Contextes</th><th>Concordances</th></tr></thead>" > $fichier_tableau # направляет сайт, удаляя содержимое предыдущее всего файла

lineno=1; #счетчик линий
#читаем линии из файла
#while read -r line;
#do
	#URL=$line;
	#HTTP=$(curl --head $URL | egrep HTTP | cut -d " " -f 2) #здесь определяем переменную, которая ищет начало в доке с урл "ХТТП" и обрезает с помощью пробела текст, берет второй элемент, который нужен (это статус сайта, работает или нет)
while read -r URL; do
	echo -e "\tURL : $URL";
	# ожидаемый способ, без опции -w в cURL
	code=$(curl -ILs $URL | grep -e "^HTTP/" | grep -Eo "[0-9]{3}" | tail -n 1)
	charset=$(curl -ILs $URL | grep -Eo "charset=(\w|-)+" | cut -d= -f2)
	charset=$(echo $charset | tr "[a-z]" "[A-Z]") #здесь мы определяем для значения шарсет команду "переделай все маленькие буквы в большие, чтобы всезде UTF-8 были одного вида
	echo -e "\tcode : $code"; 
	
	# другой способ, с помощью опции -w в cURL
	# code=$(curl -Ls -o /dev/null -w "%{http_code}" $URL)
	# charset=$(curl -ILs -o /dev/null -w "%{content_type}" $URL | grep -Eo "charset=(\w|-)+" | cut -d= -f2)
	
	if [[ ! $charset ]]
	then
			echo -e "\tencodage non détecté, on prendra UTF-8 par défaut.";
			charset="UTF-8";
	else
			echo -e "\tencodage : $charset";
	fi
	
	if [[ $code -eq 200 ]]
		aspiration=$(curl $URL > ./aspirations/$basename-$lineno.html)
	then
		if [[ $charset == 'UTF-8' ]]
		then
			dump=$(curl $URL | lynx -stdin -dump -assume_charset=$charset -display_charset=UTF-8)
		else
			dump=$(curl $URL | iconv -f $charset -t UTF-* | lynx -stdin -dump -assume_charset=UTF-8 -display_charset=UTF-8)
		fi
	else
		echo -e "\tcode différent de 200 utilisation d'un dump vide"
		dump=""
		charset=""
	fi
	# compte du nombre d'occurrences
  NB_OCC=$(grep -E -o $mot ./dumps-text/$basename-$lineno.txt | wc -l)
  # extraction des contextes
  grep -E -A2 -B2 $mot ./dumps-text/$basename-$lineno.txt > ./contextes/$basename-$lineno.txt
  # construction des concordance avec une commande externe
  
  bash programmes/concordance.sh ./dumps-text/$basename-$lineno.txt $mot > ./concordances/$basename-$lineno.html
	Count=$(echo $dump | egrep -o -i "$mot" | wc -l)
	echo "$dump" > "./dumps-text/$basename-$lineno.txt"
	
	echo "<tr><td>$lineno</td><td>$code</td><td><a href=\"$URL\">$URL</a></td><td>$charset</td><td><a href=\"../aspirations/$basename-$lineno.html\">html</a></td><td><a href=\"../dumps-text/$basename-$lineno.txt\">text</a></td><td>$NB_OCC</td><td><a href=\"../contextes/$basename-$lineno.txt\">contextes</a></td><td><a href=\"../concordances/$basename-$lineno.html\">concordance</a></td></tr>" >> $fichier_tableau  #тут мы указываем, куда заносить всю инфу и отмечаем, что при каждой итерации не нужно удалять
	echo -e "\t--------------------------------"

	lineno=$((lineno+1));
	done  < $fichier_urls
echo "</table>" >> $fichier_tableau
echo "</body></html>" >> $fichier_tableau
	
# modifier la ligne suivante pour créer effectivement du HTML
#echo "Je dois devenir du code HTML à partir de la question 3" > $fichier_tableau
