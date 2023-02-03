##Creating: AWS Instances, Installing Apache2, and configuring SSL certificate using let's encrypt CERTBOT to get a valid one.

## Aws Instance use it if it is useful
##aws ec2 run-instances --image-id ami-0591c8c8aa7d9b217 --count 1 --instance-type t2.micro --key-name driton_key --security-groups dr_test_group

#Mettre à jour la ressource de package et installer apache2
sudo apt update && apt upgrade -y
sudo apt install apache2
#Créer un répertoire pour votre domaine:
sudo mkdir /var/www/yourdomain
#Attribuer la propriété du répertoire avec la variable d'environnement
sudo chown -R $USER:$USER /var/www/yourdomain
#accorder uniquement des autorisations de lecture et d'exécution aux groupes et autres:
sudo chmod -R 755 /var/www/yourdomain
#créer un exemple de page index.html à l'aide de nano:
sudo nano /var/www/yourdomain/index.html
#collez le code ci dessous:
<html>
    <head>
        <title>Welcome to Your_domain!</title>
    </head>
    <body>
        <h1>Success!  The your_domain virtual host is working!</h1>
    </body>
</html>
#Créer un fichier d'hôte virtuel pour serveur le contenu de notre apache
sudo nano /etc/apache2/sites-available/yourdomain.conf
#collez le code ci dessous avec vos coordonnées
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName yourdomain
    ServerAlias www.yourdomain
    DocumentRoot /var/www/yourdomain
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
#Activer le fichier avec l'outil a2ensite:
sudo a2ensite your_domain.conf
#Désactiver le site par défaut défini dans 000 default.conf
sudo a2dissite 000-default.conf
#tester les erreurs de configuration
sudo apache2ctl configtest
#redémarrez apache pour prendre en compte les modifications:
sudo systemctl restart apache2
#Installez certbot pour obtenir un certificat SSL avec Let’s Encrypt
sudo apt install certbot python3-certbot-apache
#Obtention d'un certificat SSL:
sudo certbot --apache
#tester le processus de renouvellement
sudo certbot renew --dry-run


## Note:
#### We can use AWS Route 53 to obtain a subdomain or domain name, using Public IP Adresse of our Instance, and each time we should replace your_domain with our DNS name.
