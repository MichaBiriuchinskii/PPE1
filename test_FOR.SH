N=0

for ELEMENT in $(ls) 
do
  if [[ $ELEMENT =~ ^test ]]
  then 
    echo "le $N ieme élément est $ELEMENT" 
  fi
done

