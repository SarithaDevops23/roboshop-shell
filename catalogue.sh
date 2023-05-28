echo -e "\e[33mconfiguring nodejs repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33minstalling nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m user adding \e[0m"
useradd roboshop

echo -e "\e[33m creating app dir\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[33m downloading catalogue content \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app 
echo -e "\e[33m extracting downloaded content in application dirctory\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app 
echo -e "\e[33m installing nodejs dependencies npm \e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[33m setup catalogue.servive into systemd directory \e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[33m daemon reload\e[0m"
systemctl daemon-reload
systemctl enable catalogue
echo -e "\e[33m restarting catalogue\e[0m"
systemctl restart catalogue &>>/tmp/roboshop.log

echo -e "\e[33m copying mongodb repo in order to load schema we need this\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo 
echo -e "\e[33m installing mongodb client \e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[33m loading schema\e[0m"
mongo --host mongodb-dev.devops23.store </app/schema/catalogue.js &>>/tmp/roboshop.log