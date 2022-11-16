# !/ urls_russe_copy.txusr / bin / bash

if [ $# -ne 1 ]
then
	echo " ce programme demande un argument "
	exit
fi

urls_russe_copy.txt=$1


for fichier in $(ls $urls_russe_copy.txt)
do
	compteur=0
	compteur_tableau=$(($compteur_tableau+1))
	echo "
	<html>
		<head>
			<meta charset = "utf-8"/>
			<title>TABLEAU</title>
		</head>
		<body>
			<table border="6px" border-color="#008080">
				<tr>
					<th>URLS</th>
					<th>№</th>
					<th>CodeHTTP</th>
				</tr>" > tableau-$compteur_tableau.html
	while read -r line
	do
			compteur=$(($compteur+1))
			CodeHTTP=$(curl -L -w '%{http_code}\n' -o ciao.html "$line")
			echo "
				<tr>
					<td>"$line"</td>
					<td>$compteur</td>
					<td>$CodeHTTP</td>" >> tableau-$compteur_tableau.html
	done < $DOSSIER_URLS/$fichier
			echo "
				</tr>
			</table>
		</body>
	</html>" >> tableau-$compteur_tableau.html
done 
