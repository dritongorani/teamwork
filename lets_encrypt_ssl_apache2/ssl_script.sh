## Creation d'un VM AWS CLI
##aws ec2 run-instances --image-id ami-0591c8c8aa7d9b217 --count 1 --instance-type t2.micro --key-name driton_key --security-groups dr_test_group

sudo apt update && apt upgrade -y
sudo apt install apache2
sudo mkdir /var/www/yourdomain
sudo chown -R $USER:$USER /var/www/yourdomain
sudo chmod -R 755 /var/www/yourdomain
sudo nano /var/www/yourdomain/index.html
<html>
    <head>
        <title>Welcome to Your_domain!</title>
    </head>
    <body>
        <h1>Success!  The your_domain virtual host is working!</h1>
    </body>
</html>
sudo nano /etc/apache2/sites-available/yourdomain.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName yourdomain
    ServerAlias www.yourdomain
    DocumentRoot /var/www/yourdomain
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
sudo a2ensite your_domain.conf
sudo a2dissite 000-default.conf
sudo apache2ctl configtest
sudo systemctl restart apache2
sudo apt install certbot python3-certbot-apache
sudo certbot --apache
sudo certbot renew --dry-run
