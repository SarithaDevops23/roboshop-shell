source common.sh

echo -e "${color} disabling inbuilt default mysql v8, we need v5.7${nocolor}"
yum module disable mysql -y &>>/tmp/roboshop.log

echo -e "${color} settinup repo file in yum repos ${nocolor}"
cp /root/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "${color} installing mysql community server${nocolor}"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "${color} mysql starting${nocolor}"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld  

echo -e "${color} changing root password for mysql${nocolor}"
mysql_secure_installation --set-root-pass $mysql_password &>>/tmp/roboshop.log
echo -e "\e[33mchecking the userand passd working or nt${nocolor}"
mysql -uroot -p$mysql_password &>>/tmp/roboshop.log