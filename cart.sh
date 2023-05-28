echo -e "\e[33m installing nodejs setup\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[33m installing nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[33m useradd\e[0m"
#userdel roboshop
useradd roboshop
echo -e "\e[33m creating application dir \e[0m"
rm -rf /app
mkdir /app 
echo -e "\e[33m downloading application content\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app 
echo -e "\e[33m etracting content\e[0m"
unzip /tmp/cart.zip &>>/tmp/roboshop.log
cd /app 
echo -e "\e[33m installing nodejs dependencies\e[0m"
npm install &>>/tmp/roboshop.log
echo -e "\e[33m copying service file into systemd\e[0m"
cp /root/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log
echo -e "\e[33m Daemon reload\e[0m"
systemctl daemon-reload
systemctl enable cart  &>>/tmp/roboshop.log
echo -e "\e[33m cart starting\e[0m"
systemctl restart cart