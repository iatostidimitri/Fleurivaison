create database fleurivaison_db;
use fleurivaison_db;

create table roles(
id_roles int primary key auto_increment not null,
name_roles varchar(50) not null
)Engine=InnoDB;

create table users(
id_users int primary key auto_increment not null,
name_users varchar(50) not null,
first_name_users varchar(50) not null,
email_users varchar(50) not null,
password_users varchar(100) not null,
statut_users tinyint(1) default 0,
id_roles int not null
)Engine=InnoDB;

create table comments(
id_comments int primary key auto_increment not null,
content_comments text not null,
date_creation_comments datetime not null,
statut_comments tinyint(1) default 0
)Engine=InnoDB;

create table category(
id_category int primary key auto_increment not null,
name_category varchar(50) not null
)Engine=InnoDB;

create table article(
id_article int primary key auto_increment not null,
title_article varchar(50) not null,
content_article text,
date_article datetime,
statut_article varchar(50) not null
)Engine=InnoDB;

alter table users
add constraint fk_user_role
foreign key(id_roles)
references roles(id_roles);

alter table article
add constraint fk_article_category
foreign key(id_category)
references category (id_category);

alter table article
add constraint fk_article_comments
foreign key(id_comments)
references comments(id_comments);

alter table article
add constraint fk_article_comments
foreign key(id_comments)
references comments(id_comments);

alter table comments
add constraint fk_comments_users
foreign key(id_users)
references users(id_users);

alter table comments
add constraint fk_comments_article
foreign key(id_article)
references article(id_article);
