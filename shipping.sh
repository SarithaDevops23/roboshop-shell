echo -e "\e[33m installing maven\e[0m"
yum install maven -y &>>/tmp/roboshop.log

echo -e "useradd"
useradd roboshop &>>/tmp/roboshop.log
echo -e "remove existing application dir"
rm -rf /app &>>/tmp/roboshop.log
echo -e "create application dir"
mkdir /app &>>/tmp/roboshop.log
echo -e "downloading application content"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app 
echo -e "extracting content"
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

cd /app 
echo -e "clean package"
mvn clean package &>>/tmp/roboshop.log

mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "copying service file into systemd"
cp /root/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log
systemctl daemon-reload 

echo -e "installing mysql community version"
yum install mysql -y  &>>/tmp/roboshop.log
echo -e "Load schema"
mysql -h mysqldb-dev.devops23.store -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

systemctl enable shipping &>>/tmp/roboshop.log
echo -e "shipping is starting"
systemctl restart shipping