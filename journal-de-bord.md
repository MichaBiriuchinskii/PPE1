# Journal de bord du projet encadré
## On a créé le compte GitHub et le journal de bord.

- La commande "git clone <UR>" créera un nouveau dossier appelé qui sera votre copie locale du dépôt git en ligne.
- "git status" devrait nous indiquer que vous êtes à jour par rapport à la branche main.
- la commande "git log" pour voir votre dernier commit. Il faut appuyer sur la touche "q" pour sortir du log.
- la commande "git pull" - on tire les changements du dépôt distant vers notre répertoire local.
- git fetch - Permet de mettre-à-jour les métadonnées du dépôt sur votre répertoire local. git fetch a quelques avantages par rapport à pull.
  
>> PPE % echo 'moooooore' >> README.md - Ajoute une ligne à la fin du document
>> PPE % fichier README.md - Lire le type de format
README.md : texte Unicode, UTF-8 ext
>>> PPE % hexdump README.md - Montre comment le document est encodé 