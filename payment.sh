echo "installing python"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo "adding roboshop user"
useradd roboshop &>>/tmp/roboshop.log
echo "removing and creating application dir"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app 
echo "downloading applicatn content"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app 
echo "extracting content"
unzip /tmp/payment.zip &>>/tmp/roboshop.log

cd /app 
echo "installing dependencies"
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log
echo "copying payment sevice file to systemd"
cp /root/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log
echo "restart payment"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment  &>>/tmp/roboshop.log
systemctl restart payment