source common.sh

echo -e "${color} installing redis repo${nocolor}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log
echo -e "${color} enabling redis 6.2 version ${nocolor}"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log
echo -e "${color} installing redis v6.2${nocolor}"
yum install redis -y &>>/tmp/roboshop.log
echo -e "${color} replacing redis local address to 0.0.0.0 in redis.conf${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf 
echo -e "${color} replacing redis local address to 0.0.0.0 in redis/redis.conf${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf 


systemctl enable redis &>>/tmp/roboshop.log
echo -e "${color} redis starting${nocolor}"
systemctl restart redis 
