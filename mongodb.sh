echo -e "\e[33mcopying repo file to yum dir\e[0m"
cp mongodb.repo /etc/yum.repos.d
echo -e "\e[33minstalling mongo db org\e[0m"
yum install mongodb-org -y &>>/tmp/mongodb.log
## need to change default ip to 0.0.0.0
echo -e "\e[33m replacing mongod locahost to 0.0.0.0\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0' /etc/mongod.conf

systemctl enable mongod 
systemctl restart mongod  &>>/tmp/mongodb.log
echo -e "\e[34mmongo db started\e[0m"
