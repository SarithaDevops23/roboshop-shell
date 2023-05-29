source common.sh


echo -e "${color} copying repo file to yum dir${nocolor}"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo

echo -e "${color}installing mongo db org${nocolor}"
yum install mongodb-org -y &>>/tmp/mongodb.log
## need to change default ip to 0.0.0.0
echo -e "${color}replacing mongod locahost to 0.0.0.0${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

systemctl enable mongod 
systemctl restart mongod  &>>/tmp/mongodb.log
echo -e "${color}mongo db started${nocolor}"
