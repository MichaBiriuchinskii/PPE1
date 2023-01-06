# Journal de bord du projet encadré
## On a créé le compte GitHub et le journal de bord.

— 28 Septembre —
- La commande "git clone <UR>" créera un nouveau dossier appelé qui sera votre copie locale du dépôt git en ligne.
- "git status" devrait nous indiquer que vous êtes à jour par rapport à la branche main.
- la commande "git log" pour voir votre dernier commit. Il faut appuyer sur la touche "q" pour sortir du log.
- la commande "git pull" - on tire les changements du dépôt distant vers notre répertoire local.
- git fetch - Permet de mettre-à-jour les métadonnées du dépôt sur votre répertoire local. git fetch a quelques avantages par rapport à pull.
  
— 12 Octobre —
- PPE % echo 'moooooore' >> README.md - Ajoute une ligne à la fin du document
- PPE % fichier README.md - Lire le type de format
README.md : texte Unicode, UTF-8 ext
- PPE % hexdump README.md - Montre comment le document est encodé


— 19 Octobre —
- HTML - langage de balisage. Permet de structurer l’information d’un page pour la rendre visible. Dérivé du SGML “frère” du XML. Permet de marquer les zones dans du contenu textuel.  

- <balise> → le début d’une zone
- </balise> → la fin d’une zone 
- <balise/> → "ancre" 

- Quand on ouvre le page sur Internet, en fait, le navigateur telecharge le contenu du page.

- wget - commande 
- cURL - commande 

- Ils permettent de récupérer des pages web. 


— 26 Octobre —
- lynx = c’est ce qu’on va utiliser pour récuperer le texte de nos fichiers URLs. 
- lynyx -dump "lien" = effectuer une commande, sortir et transmettre le resultat sur le sortie standard (stdout>l'écran) 
- head -100 = montres les 100 premiers liens de la page web
- lynx -dump -nolist "lien" =  retire les liens de liste dans dumps

- 9 Novembre - 
- La session d'aujourd'hui a été très difficile car j'ai eu des difficultés techniques avec le mot de passe de mon référentiel, puis avec la synchronisation du dossier sur mon ordinateur et GIT. J'ai ensuite créé un site web, qui est disponible à l'adresse suivante :
https://michabiriuchinskii.github.io/PPE1/

- 16 Novembre - 
- J'ai trouvé et essayé différents modèles pour créer un site web. J'ai rencontré le premier problème : les encodages de ces sites ne reconnaissent pas les caractères en dehors de l'ASCII.
- J'ai mis à jour le script en y appliquant la décoration de table selon la norme BULMA 

- 23 Novembre - 
 - Des modifications ont été apportées au script en classe aujourd'hui. 
 - Une condition a été ajoutée pour changer l'encodage des fichiers texte s'ils ne sont pas conformes à UTF-8.
 - Une nouvelle colonne a été ajoutée à la table dans laquelle les encodages seront écrits dans un format uniforme.
 
 — 30 Novembre —
- Projet VERS 10 Janvier
- Description de projet
- Choix de mot
- Intérêt linguistique
- les démarches à suivre
- Pas d’erreurs 

 — 7 Décembre —
- Création du script "Concordances".
- Ajouter de nouvelles colonnes au tableau
- Mise à jour de la mise en page du site
- Créer de nouveaux dossiers
- Chargement des documents récupérés par le script

 — 6 Janvier —
- Optimisation des tableaux
- Résoudre les problèmes liés à l'encodage des fichiers de dump
- Résolution des problèmes de récupération des pages html
- Réparation de la requête sed à la commande gsed
- Rendre le code plus lisible
- Mise à jour des tableaux et des fichiers de tableaux
