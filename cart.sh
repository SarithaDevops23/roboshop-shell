source common.sh

echo -e "${color} installing nodejs setup${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "${color} installing nodejs${nocolor}"
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "${color} useradd${nocolor}"
#userdel roboshop
useradd roboshop
echo -e "${color} creating application dir ${nocolor}"
rm -rf /app
mkdir /app 
echo -e "${color} downloading application content${nocolor}"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app 
echo -e "${color} etracting content${nocolor}"
unzip /tmp/cart.zip &>>/tmp/roboshop.log
cd /app 
echo -e "${color} installing nodejs dependencies${nocolor}"
npm install &>>/tmp/roboshop.log
echo -e "${color} copying service file into systemd${nocolor}"
cp /root/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log
echo -e "${color} Daemon reload${nocolor}"
systemctl daemon-reload
systemctl enable cart  &>>/tmp/roboshop.log
echo -e "${color} cart starting${nocolor}"
systemctl restart cart