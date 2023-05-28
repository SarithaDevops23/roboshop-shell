echo -e "\e[33m disabling inbuilt default mysql v8, we need v5.7\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log
echo -e "\e[33m settinup repo file in yum repos \e[0m"
cp /root/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log
echo -e "\e[33m installing mysql community server\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log
echo -e "\e[33m mysql starting\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld  
echo -e "\e[33m changing root password for mysql\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log
echo -e "\e[33mchecking the userand passd working or nt\e[0m"
mysql -uroot -pRoboShop@1 &>>/tmp/roboshop.log