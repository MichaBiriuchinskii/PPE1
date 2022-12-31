#!/usr/bin/env bash

# La condition "ce script doit être exécuté à Racine et il doit y avoir tel ou tel dossier ici" peut être ajoutée au début du programme. 
#Si ce n'est pas le cas, écrit pour dire qu'il faut créer le bon environnement pour le script.

fichier_urls=$1 # le fichier d'URL en entrée
fichier_tableau=$2 # le fichier HTML en sortie

#si le nombre d'éléments n'est pas égale à 2, on exit, on précise les conditions du programme
if [  $# != 2  ]
then 
			echo "il faut 2 paramètres"
			echo "Syntaxe : script_URL_traitement.sh (1) nom_fichier_URL (2) nom_fichier_HTML"
			exit
fi

mot=$(egrep "(имм|эм)игр\w+" $fichier_urls)

basename=$(basename -s .txt $fichier_urls)
#basename -s supprime le chemin, ne laissant que le nom du fichier. L'option -s supprime l'extension (également appelée suffixe)

#c'est ici que l'on commence à créer le site web, en prescrivant les conditions de création du tableau et son design

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
									<thead><tr><th>ID</th><th>code HTTP</th><th>URL</th><th>Encodage</th><th>HTML</th><th>Dump</th><th>Occurences</th><th>Contextes</th><th>Concordances</th></tr></thead>" > $fichier_tableau # dirige le site en supprimant le contenu du fichier entier précédent

lineno=1; #compteur de lignes

while read -r URL; 
do
			echo -e "\tURL : $URL";
			code=$(curl -ILs $URL | grep -e "^HTTP/" | grep -Eo "[0-9]{3}" | tail -n 1) # de la manière attendue, sans l'option -w de cURL
			charset=$(curl -ILs $URL | grep -Eo "charset=(\w|-)+" | cut -d= -f2)
			charset=$(echo $charset | tr "[a-z]" "[A-Z]") #ici nous définissons pour la valeur sharset la commande "convertir toutes les petites lettres en majuscules, afin que toutes les lettres UTF-8 soient du même type
			echo -e "\tcode : $code"; 
		
			if [[ -z $charset ]]
			then
						echo -e "\tencodage non détecté, on prendra UTF-8 par défaut.";
						charset="UTF-8";
			else
						echo -e "\tencodage : $charset";
			fi
	
			if [[  $code -eq 200  ]]
			then
						aspiration=$(curl $URL > ./aspirations/$basename-$lineno.html)
						if [[  $charset == 'UTF-8'  ]]
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
			
			echo "$dump" > "./dumps-text/$basename-$lineno.txt"
			echo "$aspiration" > "./aspirations/$basename-$lineno.html"

	# compte du nombre d'occurrences
	
NB_OCC=$(grep -E -o $mot ./dumps-text/$basename-$lineno.txt | wc -l)
  # extraction des contextes
grep -E -A2 -B2 $mot ./dumps-text/$basename-$lineno.txt > ./contextes/$basename-$lineno.txt
  # construction des concordance avec une commande externe
bash programmes/concordance.sh ./dumps-text/$basename-$lineno.txt $mot > ./concordances/$basename-$lineno.html
Count=$(echo $dump | egrep -o -i "$mot" | wc -l)
	
			echo "<tr><td>$lineno</td><td>$code</td><td><a href=\"$URL\">$URL</a></td><td>$charset</td><td><a href=\"../aspirations/$basename-$lineno.html\">html</a></td><td><a href=\"../dumps-text/$basename-$lineno.txt\">text</a></td><td>$NB_OCC</td><td><a href=\"../contextes/$basename-$lineno.txt\">contextes</a></td><td><a href=\"../concordances/$basename-$lineno.html\">concordance</a></td></tr>" >> $fichier_tableau  #Nous spécifions ici où placer toutes les informations et notons qu'il n'est pas nécessaire de les supprimer à chaque itération
			echo -e "\t--------------------------------"
			lineno=$((lineno+1));
			
done  < $fichier_urls

echo "		</table>
	</body>
</html>" >> "tableaux/$fichier_tableau"
	
