#! /bin/bash
# script.sh
# lancer le script principale
echo "installer serveur apache"
sudo apt update
sudo apt install apache2
echo "installer module PHP"
sudo apt install libapache2-mod-php
echo " installer  le SGBD MYSQL"
sudo apt update 
sudo  apt install mysql-server

echo  "creation d'une BD relative a votre projet "
echo "creation d'un user ayant tous les droits"
echo " create database db_app; create user admin  identified by 'admin'; 
grant all on db_app.* to admin@'%';"| sudo mysql
echo "creation d'un table et remplir"
echo " tester l'accées a la base  et afficher le contenu de la table"
echo " create table inscription (id int NOT NULL AUTO_INCREMENT ,
name varchar(20) DEFAULT NULL,
email varchar(50) DEFAULT NULL,
PRIMARY KEY (id)
);
insert into  inscription (name ,email) values ('user1', 'user1@gmail.com'), ('user2', 'user2@gmail.com');
use db_app; show databases; show tables;
show columns in inscription; select * from inscription ;"| sudo mysql -u admin -p -D db_app  -h 192.168.56.20 -P 3306
echo " créer et héberger des pages php"
cd /var/www/html
sudo touch index.html
sudo chmod 777 index.html
echo "<html>
<head><title>page index </title></head>
<body><h2> page index </h2><a href='index.php'> page principale</a></body></html>" > index.html
sudo touch index.php
sudo chmod 777 index.php
echo " <html>
<head><title> page index.php </title></head>
<body> <h2> page php</h2><p><?php echo 'site web etidel abdelkader'; ?></p>
<h4> liste users </h4>
<table border=2><tr><th>name</th><th>email</th></tr>
<?php 
\$bdd = new PDO('mysql:host = 192.168.56.20.;dbname=db_app', 'admin','admin');
\$response = \$bdd ->query('select *from inscription');
while (\$d = \$response ->fetch ()) { ?><tr><td><?php echo \$d['name']; ?></td>
<td><?php echo \$d['email']; ?></td></tr> 
<?php } ?>
</table></body></html>" > index.php 
