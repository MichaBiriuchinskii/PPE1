if [[ $# -ne 1 ]]
then
  echo "Usage : $0 <URL>"
  exit
fi

fichier_url=$1

while read -r URL
do
  echo $URL
done < $fichier_url
