#!/bin/bash

echo -e '\e[44m \e[30m##############################################################\e[0m'
echo -e '\e[44m \e[30m#                         WELCOME!                           #\e[0m'
echo -e '\e[44m \e[30m#                                                            #\e[0m'
echo -e '\e[44m \e[30m#                SSH/SSL/OPENVPN WEB PANEL V5                #\e[0m'
echo -e '\e[44m \e[30m#                     AUTOSCRIPT BY BAA                      #\e[0m'
echo -e '\e[44m \e[30m##############################################################\e[0m'
echo ""
read -n 1 -s -p "This script will install ssh web administrator press a key to continue"
echo ""
read -n 1 -s -p "I am not responsible for damage caused by the script press a key"
echo ""
read -n 1 -s -p "port NECESSARY 80 required system UBUNTU 14 and a clean system without mysql"
echo ""
echo -e '\e[1;32m Enter install serial #:\e[0m'
read -p "Enter serial: " password
if [[ -z $password ]]
then
    tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "You have typed an empty serial!" ; echo "" ; tput sgr0
    exit 1
else
    sizepass=$(echo ${#password})
    if [[ $sizepass -lt 9 ]]
    then
        tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "You have typed a very short serial!" ; echo "Verify your serial with the script administrator" ; echo "Enter a correct combination!" ; echo "" ; tput sgr0
        exit 1
    else
        echo""
    fi  
fi
apt-get install curl -y  1> /dev/null 2> /dev/stdout
#curl -b -w -uitercds:Vpninet --silent http://itercds.systems/serial/datas --stderr - | grep  $password
curl -L -b -w --silent https://www.dropbox.com/s/co3puiwfvplh2zm/datas.txt?dl=0 --stderr - | grep $password
if [[ $? > 0 ]]
then
    echo -e '\e[0;31m Invalid serial\e[0m'
    exit
else
     echo -e '\e[1;34m Can continue\e[0m'
fi
sleep 1
dato2="2"
dato1="1"
echo -e '\e[40m \e[1;32m THIS SCRIPT WILL INSTALL ALL COMPLEMENTS NEEDED FOR THE PANEL \e[0m'
echo -e '\e[40m \e[1;32m INSTALL THE WEB PANEL \e[0m#(1)'
echo -e '\e[40m \e[1;32m UNINSTALL PANEL      \e[0m#(2)'
echo -e '\e[40m \e[1;33m WHAT WOULD YOU LIKE TO DO       \e[0m#(?)'
read -p 'ANSWER enter a value:#(?)' valor
if test "$valor" = "$dato2"
then
    echo -e '\e[1;31Miniaturizing dismantling'
            apt-get purge nginx -y  1> /dev/null 2> /dev/stdout
            if [[ $? > 0 ]]
            then
            echo "No NGINX server found, exiting.#1"
            exit
            else
            echo "The command ran successfully, continuing with script." 1> /dev/null 2> /dev/stdout
            fi
            apt-get autoremove nginx -y 1> /dev/null 2> /dev/stdout
            rm -R /usr/share/nginx/html 1> /dev/null 2> /dev/stdout
            mkdir /usr/share/nginx/html 1> /dev/null 2> /dev/stdout          
            if [[ $? > 0 ]]
            then
            echo "Uninstallation error, exiting.#2"
            exit
            else 
            echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
            fi
            #sudo apt purge php7.0-mysql php7.0-curl php7.0-json php7.0-cgi  php7.0 libapache2-mod-php7.0 
            #service mysql stop
            #sudo apt-get remove apache2 mysql-server libapache2-mod-auth-mysql php5-mysql php5 libapache2-mod-php5 php5-mcrypt 
            apt-get purge php5* -y 1> /dev/null 2> /dev/stdout
            if [[ $? > 0 ]]
            then
            echo "Package php5 was not found, exiting.#3"
            exit
            else
            echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
            fi
            sudo apt-get remove --purge mysql-server mysql-client mysql-common -y 1> /dev/null 2> /dev/stdout
            rm startserver.sh
            if [[ $? > 0 ]]
            then
            echo "Package mysql was not found, exiting.#4"
            exit
            else
            echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
            fi
            sudo rm -rf /etc/mysql/  1> /dev/null 2> /dev/stdout
            if [[ $? > 0 ]]
            then
            echo "The command failed, exiting.#5"
            exit
            else
            echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
            fi
            deluser --remove-home mysql 1> /dev/null 2> /dev/stdout
            if [[ $? > 0 ]]
            then
            echo "The command failed, exiting.#6"
            exit
            else
            echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
            fi
            apt-get purge libssh2-php -y 1> /dev/null 2> /dev/stdout
            if [[ $? > 0 ]]
            then
            echo "Package libssh2-php was not found, exiting.#7"
            exit
            else
            echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
            fi
            rm -rf /etc/apparmor.d/abstractions/mysql /etc/apparmor.d/cache/usr.sbin.mysqld /etc/mysql /var/lib/mysql /var/log/mysql* /var/log/upstart/mysql.log* /var/run/mysqld 1> /dev/null 2> /dev/stdout
            updatedb
            apt-get purge zip -y 1> /dev/null 2> /dev/stdout
            apt-get autoremove -y 1> /dev/null 2> /dev/stdout
    echo -e '\e[1;32mUninstall finished \e[0m'
    exit
elif test "$valor" = "$dato1"
then
     echo -e '\e[1;32mContinue with the installation '
     sleep 2
else
           echo -e '\e[1;31mWrong answer \e[0m' 
exit
fi
read -n 1 -s -p "Be very careful enter user and pass root"
echo ""
read -p "Username: " USER
read -p "Password: " PASSWORD
read -p "Enter your IP: " ip
echo -ne '#                    (10%)\r'
sleep 1
echo -ne '##                   (15%)\r'
sleep 2
apt-get update 1> /dev/null 2> /dev/stdout  && apt-get upgrade -y 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "Update failed, exiting.#10"
    exit
else
    echo "Updating, continuing with script." 
fi
echo -ne '###                  (20%)\r'
sleep 1
apt-get install curl -y 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "Installation of curl failed, exiting. # 11"
    exit
else
    echo "Installing CURL, continuing with script."
fi
echo -ne '####                 (25%)\r'
sleep 1
sudo apt-get install nginx -y  1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "Package nginx installation failed, exiting.#12"
    exit
else
    echo "Installing NGINX, continuing with script."
fi
echo -ne '#####                (30%)\r'
sleep 1
rm -R /etc/nginx/sites-available/ 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#13"
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo -ne '######               (35%)\r'
sleep 2
mkdir -p /etc/nginx/sites-available/ 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#14"
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo -ne '#######               (40%)\r'
sleep 1
cd /etc/nginx/sites-available/ 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#15"
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo -ne '########              (45%)\r'
sleep 1
wget https://www.dropbox.com/s/yvfb29cmps728hk/default  1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "DLink expired, exiting.#16"
    exit
else
    echo "Configuring NGINX, continuing with script."
fi
echo -ne '############          (50%)\r'
sleep 1
#sudo add-apt-repository ppa:ondrej/php
#if [[ $? > 0 ]]
#then
#    echo "The command failed, exiting.#14"
#    exit
#else
#    echo "The command ran succesfuly, continuing with script."
#fi
#sudo apt-get update 
#if [[ $? > 0 ]]
#then
#    echo "The command failed, exiting.#15"
#    exit
#else
#    echo "The command ran succesfuly, continuing with script."
#fi
#sudo apt search php7 
#if [[ $? > 0 ]]
#then
#    echo "The command failed, exiting.#16"
#    exit
#else
#    echo "The command ran succesfuly, continuing with script."
#fi
#sudo apt install  php7.1-curl php7.1-json php7.1-cgi php7.1-zip php7.1-xml php7.1-curl php7.1-gd php7.1-mbstring php7.1-bcmath -y 
#if [[ $? > 0 ]]
#then
#    echo "The command failed, exiting.#17"
#    exit
#else
#    echo "The command ran succesfuly, continuing with script."
#fi
#sudo apt-get install mcrypt php7.0-mcrypt
#if [[ $? > 0 ]]
#then
#    echo "The command failed, exiting.#27"
#    exit
#else
#    echo "The command ran succesfuly, continuing with script."
#fi
#sudo apt-get install php7.0-ssh2
echo -ne '###########          (55%)\r'
sleep 1
sudo apt-get install php-ssh2 -y  1> /dev/null 2> /dev/stdout && service nginx restart  1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "Installation failed of package libssh2-php, exiting.#17"
    exit
else
    echo "Installing libssh2-php, continuing with script."
fi
echo -ne '############         (56%)\r'
sleep 1
apt-get install libssh2-1-dev php-ssh2 -y 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "Package libssh2-php is bugged, exiting.#18"
    exit
else
    echo "Configuring libssh2-php, continuing with script." 
fi

if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#19"
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo -ne '#############        (57%)\r'
sleep 1
apt-get -y install php7.0-fpm php7.0-mysql -y 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "Package php7 installation failed, exiting.#20"
    exit
else
    echo "Installing PHP, continuing with script."
fi
echo -ne '##############       (58%)\r'
sleep 1
service nginx restart 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "NGINX restart failed, exiting.#21"
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo -e '\e[44m \e[30m# ENTER YOUR PASSWD ROOT#\e[0m'
echo -ne '###############       (60%)\r'
sleep 2
apt-get install mariadb-server -y
if [[ $? > 0 ]]
then
    echo "Package mysql installation failed, exiting.#22"
    exit
else
    echo "Installing mysql, continuing with script."
fi
echo -ne '###############     (61%)\r'
sleep 2
clear
mysql_secure_installation
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#23" 1> /dev/null 2> /dev/stdout
    exit
else 
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo -ne '###############       (62%)\r'
sleep 1

if [[ $? > 0 ]]
then
    echo "Package mysql configuration failed, exiting.#24"
    exit
else
    echo "Configuring mysql, continuing with script."
fi
echo -ne '###############      (70%)\r'
sleep 1
service nginx restart 1> /dev/null 2> /dev/stdout 
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#25" 1> /dev/null 2> /dev/stdout
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
mysql -h localhost -u$USER -p$PASSWORD -e "CREATE DATABASE ssh" 1> /dev/null 2> /dev/stdout
clear
echo -e '\e[1;32m Database Created #: \e[0m'
echo -ne '##################     (75%)\r'
sleep 1
wget -q --no-check-certificate https://www.dropbox.com/s/7kfpjnmrzb604se/ssh.sql -O /tmp/ssh.sql 1> /dev/null 2> /dev/stdout
mysql -u$USER -p$PASSWORD --default-character-set=utf8 ssh </tmp/ssh.sql 1> /dev/null 2> /dev/stdout
rm /tmp/ssh.sql 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "Link expired, exiting.#26" 
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo -ne '##################     (75%)\r'
sudo apt-get update 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#27" 1> /dev/null 2> /dev/stdout
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
apt-get install php7.0-cli -y 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#php5-cli" 
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
php -m |grep ssh2 1> /dev/null 2> /dev/stdout
#if [[ $? > 0 ]]
#then
#    echo "The command failed, exiting."
#    exit
#else
#    echo "The command ran succesfuly, continuing with script."
#fi
echo -ne '##################     (75%)\r'
sleep 1
apt-get install php7.0-curl -y 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#28" 
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo -ne '##################     (75%)\r'
sleep 1
service nginx restart 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#29"
    exit
else
    echo "Verifying Files, continuing with script."
fi
echo -ne '##################     (75%)\r'
sleep 1
rm -R /usr/share/nginx/html
mkdir /usr/share/nginx/html
cd /usr/share/nginx/html 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#30"
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo -ne '####################   (80%)\r'
wget -q --no-check-certificate https://www.dropbox.com/s/1bvmpps3aq670pw/panelv5.zip 1> /dev/null 2> /dev/stdout && apt-get install zip -y   1> /dev/null 2> /dev/stdout && unzip panelv5.zip 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "Link expired, exiting.#31"
    exit
else
    echo "Downloading webssh, continuing with script."
fi
echo -ne '####################   (80%)\r'
sleep 1
ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
if [[ $? > 0 ]]
then
    echo "Failed to set time, exiting.#32"
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo -ne '###################### (85%)\r'
sleep 1
service nginx restart 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#33" 1> /dev/null 2> /dev/stdout
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo -ne '###################### (85%)\r'
sleep 1
cd /usr/share/nginx/html 1> /dev/null 2> /dev/stdout
chmod -R 777 scripts
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#34"
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
cd /usr/share/nginx/html/admin/pages 1> /dev/null 2> /dev/stdout
echo -ne '###################### (85%)\r'
sleep 1
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#35"
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo -ne '######################  (85%)\r'
sleep 1
chmod 777 bandeiras
chmod 777 download
chmod 777 index.html
chmod -R 777 servidor
chmod -R 777 usuario
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#36"
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo -ne '###################### (90%)\r'
sleep 1
cd /usr/share/nginx/html/pages 1> /dev/null 2> /dev/stdout
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#37"
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
rm /usr/share/nginx/html/pages/system/pass.php
echo -e "<?php \$pass = '$PASSWORD';?>" >> /usr/share/nginx/html/pages/system/pass.php
chmod -R 777 servidor
chmod -R 777 system
chmod -R 777 usuario
echo -ne '###################### (100%)\r'
sleep 1
crontab <<-EOF
@reboot sshlimiter.sh
* * * * * /usr/bin/php /usr/share/nginx/html/pages/system/cron.php
* * * * * /usr/bin/php /usr/share/nginx/html/pages/system/cron.ssh.php
* * * * * /usr/bin/php /usr/share/nginx/html/pages/system/cron.sms.php
* * * * * /usr/bin/php /usr/share/nginx/html/pages/system/cron.online.ssh.php
10 * * * * /usr/bin/php /usr/share/nginx/html/pages/system/cron.servidor.php
*/5 * * * * sudo ./startserver.sh
EOF
if [[ $? > 0 ]]
then
    echo "The command failed, exiting.#38"
    exit
else
    echo "The command ran succesfuly, continuing with script." 1> /dev/null 2> /dev/stdout
fi
echo "verificadno instalacion "
function ProgressBar {
# Process data
    let _progress=(${1}*100/${2}*100)/100
    let _done=(${_progress}*4)/10
    let _left=40-$_done
# Build progressbar string lengths
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")

# 1.2 Build progressbar strings and print the ProgressBar line
# 1.2.1 Output example:
# 1.2.1.1 Progress : [########################################] 100%
printf "\rProgress : [${_fill// /#}${_empty// /-}] ${_progress}%%"

}

# Variables
_start=1

# This accounts as the "totalState" variable for the ProgressBar function
_end=100

# Proof of concept
for number in $(seq ${_start} ${_end})
do
    sleep 0.1
    ProgressBar ${number} ${_end}
done
wget https://www.dropbox.com/s/e8qe53pwuoybunl/startserver.sh 1> /dev/null 2> /dev/stdout
chmod 777 startserver.sh 1> /dev/null 2> /dev/stdout
printf '\nFinished!\n'
clear 
    echo -e '\e[44m \e[30m##############################################################\e[0m'
    echo -e '\e[44m \e[30m#                         WELCOME!                           #\e[0m'
    echo -e '\e[44m \e[30m#                                                            #\e[0m'
    echo -e '\e[44m \e[30m#                SSH/SSL/OPENVPN WEB PANEL V5                #\e[0m'
    echo -e '\e[44m \e[30m#                     AUTOSCRIPT BY BAA                      #\e[0m'
    echo -e '\e[44m \e[30m##############################################################\e[0m'
    echo -e "
    WEB PANEL http://$ip:80
    USERNAME:\e[0;31m admin\e[0m
    PASSWORD:\e[0;31m admin\e[0m"

