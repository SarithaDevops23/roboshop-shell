echo -e "\e[33m installing nodejs configuration setup\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33m installing nodejs \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m user adding \e[0m"
useradd roboshop
echo -e "\e[33m creating application directory\e[0m"
mkdir /app 
echo -e "\e[33m downloading application content\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip  &>>/tmp/roboshop.log
cd /app 
echo -e "\e[33m extracting application content\e[0m"
unzip /tmp/user.zip &>>/tmp/roboshop.log

cd /app 
echo -e "\e[33m installing npm\e[0m"
npm install  &>>/tmp/roboshop.log

echo -e "\e[33m copying service file into systemd\e[0m"
cp /root/roboshop-shell/user.service /etc/systemd/system/user.service 

echo -e "\e[33m daemon reload \e[0m"
systemctl daemon-reload
systemctl enable user &>>/tmp/roboshop.log
echo -e "\e[33m start user\e[0m"
systemctl restart user

echo -e "\e[33m copying mondb repo\e[0m"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo 

echo -e "\e[33m installing mongodb client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "\e[33m load schema\e[0m"
mongo --host mongodb-dev.devops23.store </app/schema/user.js &>>/tmp/roboshop.log

