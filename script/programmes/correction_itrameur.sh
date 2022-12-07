# !/ urls_russe_copy.txusr / bin / bash

#этот скрипт должен открываться с racine папки 
# $ ./programmes/correction_itrameur.sh

if [ []$# -ne 2]
then
	echo "Deux arguments attendus : <dossier> <langue>"
	exit
fi

folder=$1 #dumos-text OU contextes
basename=$2 #en, fr, ru, it, etc.

echo "<lang=\ "$basename\ ">" > "./itrameur/$folder-$basename.txt" 

for filepath in $(ls $folder/$basename -*.txt) #определяет путь к папке
do
	#filepath == dumps-textes/fr-1.txt
	# ===> pagename = fr -1
	pagename=$(basename -s .txt $filepath)
	echo "<page=\ "$pagename\ ">" >> "./itrameur/$folder-$basename.txt"
	echo "<text>"
	
	content=$(cat $filepath)
	#порядок слов типо тут важен : & сначала стоит
	#если не так : < => &lt ; => amp ;lt ;
	content=$(echo "$content" | sed ' s/&/&amp ; /g')
	content=$(echo "$content" | sed ' s/</&lt ; /g')
	content=$(echo "$content" | sed ' s/>/&gt ; /g')
	
	echo "$content" >> "./itrameur/$folder-$basename.txt"
	echo "</text>" >> "./itrameur/$folder-$basename.txt"
	echo "</page> §" >> "./itrameur/$folder-$basename.txt"
	
done

echo "</lang>" >> "./itrameur/$folder-$basename.txt"
