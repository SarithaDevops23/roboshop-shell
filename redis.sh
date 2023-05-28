echo -e "\e[33m installing redis repo\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log
echo -e "\e[33m enabling redis 6.2 version \e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log
echo -e "\e[33m installing redis v6.2\e[0m"
yum install redis -y &>>/tmp/roboshop.log
echo -e "\e[33m replacing redis local address to 0.0.0.0 in redis.conf\e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf 
echo -e "\e[33m replacing redis local address to 0.0.0.0 in redis/redis.conf\e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf 


systemctl enable redis &>>/tmp/roboshop.log
echo -e "\e[33m redis starting\e[0m"
systemctl restart redis 
