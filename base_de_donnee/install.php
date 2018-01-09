/*****************************************************************************
*
*             *******************************
*             ** Comment installer / tips: **
*             *******************************
*
*   Le dossier du projet s'intitule: roombooking
*   Le seul fichier de code à modifier est: "config.inc.php"
*   vous l'aurez compris, c'est pour configurer l’accès a la base de donnée
*   que vous allez créer par la suite (plus bas).
*
*   Dans ce fichier il faudra modifier les lignes suivantes:
*   $db_host (dans mon cas = localhost)
*   $db_login (dans mon cas l'identifiant pour accéder a la bdd = root)
*   $db_password (dans mon cas il n'y a pas de mot de passe)
*   Warning: Ne pas modifier les autres lignes.
*
*   Installer la base de données:
*   Dans le même dossier que ce fichier (install.php), càd roombooking/base_de_donnee
*   vous trouverez le fichier qui va vous permettre d'installer les tables
*   dans la base de données (mrbs.sql). Premierement, il faut créer une base de données
*   et la nommer "mrbs". Ensuite il ne reste plus qu'à importer le fichier "mrbs.sql".
*   Ceci étant fait, vous disposez d'une base de données avec toutes ses tables,
*   mais aussi 1 lieu (UHA 4.0), 2 salles (Salle Bartholdi et Salle Conf),
*   ainsi que 2 utilisateurs (etrit=admin, florent=admin :pass=123).
*
*   Comment ajouter/supprimer/modifier utilisateur:
*   Important: Il ne faut en aucun cas supprimer tous les admin (sinon aucun contrôle)
*   ps: avant de supprimer le dernier admin, un message sera affiché afin de vous avertir
*
*   Arrivé sur la page d'accueil, il faut cliquer en haut à droite de la page
*   sur "Utilisateur non identifié", il vous sera demandé de vous identifier
*   Ensuite vous serez sur la page "liste des utilisateurs", c'est ici que
*   tout ajout/modification des utilisateurs se fera.
*
*   Ajouter un nouvel utilisateur:
*   Cliquez tout simplement sur "Ajouter un nouvel utilisateur",
*   remplissez et enregistrez.
*   Attention: La case "Droit" doit être sur "user" sauf si on veut ajouter un nouvel
*              admin.
*   Password: donnez un mot de passe aléatoire à votre nouvel utilisateur
*             et transmettez-le-lui afin qu'il puisse se connecter une première fois
*             avant de le modifier lui-même.
*   Supprimer: Facile, dans cette même liste sélectionnez l'utilisateur que
*              vous souhaitez supprimer (vous seul en tant qu'admin aurez accès
*              a tous les utilisateurs), cliquez sur le nom d'utilisateur
*              et vous pourrez modifier son mot de passe
*              ou le supprimer complètement en cliquant sur "Supprimer cet utilisateur".
*   Attention: après suppression de l'utilisateur, ses réservations ne seront pas effacées
*              Afin de supprimer ses réservation:
*              Allez dans la base de données "mrbs" et inscrivez cette ligne sql:
*              DELETE FROM `mrbs_entry` WHERE `create_by`= 'utilisateur'
*              'utilisateur' = nom de l'utilisateur bien évidemment :)
*
*   Ajouter lieu ou salle
*   lieu= endroit ou étage (ici: UHA 4.0)
*   salle= nom ou numéro de la salle
*   Cliquez sur Salle (Menu en haut), ici vous pourrez modifier/supprimer le "Lieu"
*   en modifiant le lieu, vous pourrez aussi ajuster la durée d'une journée
*   (heure de début et de fin).
*
*   Sur cette page vous pourrez aussi ajouter/supprimer une salle
*   mais vous ne pourrez pas modifier la salle.
*   ps: seul l'admin peut ajouter/supprimer/modifier salle ou lieu
*
*   L'admin peut aussi supprimer/modifier n'importe quelle réservation.
*
*   chaque utilisateur est rangé par rang, ceci défini ses pouvoirs:
*   0 = aucun (visiteur): aucun droit d'ajout ou de modification
*   1 = user (utilisateur): peut ajouter et modifier ses ajouts
*   2 = admin (administrateur): a tous les droits possibles
*
*
******************************************************************************/
