# !/ urls_russe_copy.txusr / bin / bash
#!/usr/bin/bash

fichier_text=$1
motif=$2

if [[ $# -ne 2 ]]
then
	echo "Ce programme demande exactement deux arguments."
	echo "Usage : $0 <fichier> <motif>"
	exit
fi

if [[ ! -f $fichier_text ]]
then
  echo "le fichier $fichier_text n'existe pas"
  exit
fi

if [[ -z $motif ]]
then
  echo "le motif est vide"
  exit
fi

echo 	"
            <html>
             <html lang=\"ru\">
			 <head>
							<meta charset=\"utf-8\" /> 
							<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css\">
							<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
							<title>Concordance</title>
			</head>
			<body>
							<h1 class=\"title\">Concordance</h1>
							<table class=\"table is-bordered is-striped is-narrow is-hoverable is-fullwidth\">
									<thead>
									<tr>
									<th class=\"has-text-right\">Contexte gauche</th>
									<th class=\"has-text-centered\">Cible</th>
									<th class=\"has-text-left\">Contexte droit</th>
									</tr>
									</thead>
									" 
grep -E -o "(\w+\W+){0,5}\b$motif\b(\W+\w+){0,5}" $fichier_text | gsed -E "s/(.*)$motif(.*)/<tr><td class="has-text-right">\1<\/td><td class="has-text-danger has-text-centered">\2<\/td><td class="has-text-left">\3<\/td><\/tr>/" #какая-то хрень с sed не работает тут

echo "		</table>
	        </body>
    </html>"