echo -e "\e[34mcopying repo file to yum dir\e[0m"
cp mongodb.repo /etc/yum.repos.d
echo -e "\e[34minstalling mongo db org\e[0m"
yum install mongodb-org -y &>>/tmp/mongodb.log
## need to change default ip to 0.0.0.0
systemctl enable mongod 
systemctl restart mongod  &>>/tmp/mongodb.log
echo -e "\e[34mmongo db started\e[0m"
