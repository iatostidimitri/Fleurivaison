create database fleurivaison;
use fleurivaison;

create table utilisateur(
id_utilisateur int primary key auto_increment not null,
nom_utilisateur varchar(50) not null,
prenom_utilisateur varchar(50) not null,
email_utilisateur varchar(50) unique not null,
mdp_utilisateur varchar(100) not null,
photo_profil_utilisateur varchar(50) not null,
statut_utilisateur tinyint(1) default 0,
id_article int not null
)Engine=InnoDB;


create table article(
id_article int primary key auto_increment not null,
titre_article varchar(50) not null,
contenu_article text not null,
statut_article tinyint(1) default 0,
id_categorie int not null,
id_utilisateur int not null,
id_commande int not null
)Engine=InnoDB;

create table categorie(
id_categorie int primary key auto_increment not null,
nom_categorie varchar(50) not null,
id_article int not null
)Engine=InnoDB;

create table commentaires(
id_commentaires int primary key auto_increment not null,
contenu_commentaires varchar(200) not null,
date_creation_commentaires datetime not null,
statut_commentaires tinyint(1) default 0,
id_article int not null,
id_utilisateur int not null
)Engine=InnoDB;

create table photo(
id_photo int primary key auto_increment not null,
url_photo varchar(100) not null,
nom_photo varchar(50) not null,
id_article int not null
)Engine=InnoDB;

create table commande(
id_commande int primary key auto_increment not null,
numero_commentaire int not null,
date_commande datetime not null,
methode_paiement_commande varchar(100) not null,
statut_commentaire tinyint(1) default 0,
id_adresse_livraison int not null,
id_suivi_livraison int not null,
id_utilisateur int not null
)Engine=InnoDB;

create table note(
id_note int primary key auto_increment not null,
date_note datetime not null,
score_note int not null,
id_commentaires int not null,
id_utilisateur int not null
)Engine=InnoDB;

create table adresse_livraison(
id_adresse_livraison int primary key auto_increment not null,
nom_adresse_livraison varchar(50) not null,
prenom_adresse_livraison varchar(50) not null,
rue_adresse_livraison varchar(50) not null,
cp_adresse_livraison varchar(50) not null,
ville_adresse_livraison varchar(50) not null,
telephone_adresse_livraison varchar(50) not null,
id_utilisateur int not null
)Engine=InnoDB;


create table type_adresse(
id_type_adresse int primary key auto_increment not null,
nom_type_adresse varchar(50) not null,
id_adresse_livraison int not null
)Engine=InnoDB;

create table suivi_livraison(
id_suivi_livraison int primary key auto_increment not null,
numero_suivi_livraison smallint not null
)Engine=InnoDB;

create table document(
id_document int primary key auto_increment not null,
numero_document smallint not null,
date_document datetime not null,
id_commande int not null,
id_type_document int not null
)Engine=InnoDB;

create table type_document(
id_type_document int primary key auto_increment not null,
nom_type_document varchar(50) not null
)Engine=InnoDB;


-- table association

create table abonner(
abonne int not null,
utilisateur int not null,
primary key(abonne, utilisateur)
)Engine=InnoDB;

create table appartenir(
id_utilisateur int not null,
id_groupe int not null,
primary key(id_utilisateur, id_groupe)
)Engine=InnoDB;

create table illustrer(
id_article int not null,
id_media int not null,
primary key(id_article, id_media)
)Engine=InnoDB;

create table envoyer(
destinataire int not null,
expediteur int not null,
id_message int not null,
primary key(destinataire,expediteur,id_message)
)Engine=InnoDB;

-- contraintes foreign key

alter table utilisateur
add constraint fk_posseder_role
foreign key(id_role_utilisateur)
references role_utilisateur(id_role_utilisateur);

alter table article
add constraint fk_rediger_utilisateur
foreign key(id_utilisateur)
references utilisateur(id_utilisateur);

alter table article
add constraint fk_categoriser_categorie
foreign key(id_categorie)
references categorie(id_categorie);

alter table commentaire
add constraint fk_completer_utilisateur
foreign key(id_utilisateur)
references utilisateur(id_utilisateur);

alter table commentaire
add constraint fk_completer_commentaire
foreign key(id_article)
references article(id_article);

-- contrainte table association

alter table ajouter
add constraint fk_ajouter_article
foreign key(utilisateur)
references utilisateur (id_utilisateur);

alter table ajouter
add constraint fk_ajouter_article
foreign key(article)
references article (id_article);

alter table avoir
add constraint fk_avoir_commentaires
foreign key(id_article)
references article(id_article);

alter table relier
add constraint fk_relier_note
foreign key(id_commentaires)
references commentaires(id_commentaires);



alter table illustrer
add constraint fk_illustrer_photo
foreign key(id_photo)
references media(id_photo);

alter table donner
add constraint fk_donner_note
foreign key(note)
references note(id_note);

alter table laisser
add constraint fk_laisser_commentaire
foreign key(utilisateur)
references utilisateur(id_utilisateur);

alter table passer
add constraint fk_passer_commande
foreign key(id_commande)
references commande(id_commande);

alter table fournir
add constraint fk_fournir_adresse_livraison
foreign key(utilisateur)
references utilisateur(id_utilisateur);

alter table afficher
add constraint fk_afficher_adresse_livraison
foreign key(utilisateur)
references utilisateur(id_utilisateur);

alter table choisir
add constraint fk_choisir_type_adresse
foreign key(adresse_livraison)
references adresse_livraison(id_adresse_livraison);

alter table rattacher
add constraint fk_rattacher_categorie
foreign key(article)
references article(id_article);

alter table contenir
add constraint fk_contenir_commande
foreign key(article)
references article(id_article);

alter table associer
add constraint fk_associer_document
foreign key(commande)
references commande (id_commande);


alter table referer
add constraint fk_referer_suivi_livraison
foreign key(commande)
references commande (id_commande);

alter table specifier
add constraint fk_specifier_type_document
foreign key(type_document)
references type_document(id_type_document);

