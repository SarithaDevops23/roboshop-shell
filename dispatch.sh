yum install golang -y >>&/tmp/roboshop.log
useradd roboshop

rm -rf /app >>&/tmp/roboshop.log
mkdir /app 

curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip  >>&/tmp/roboshop.log
cd /app 
unzip /tmp/dispatch.zip >>&/tmp/roboshop.log

cd /app 
go mod init dispatch >>&/tmp/roboshop.log
go get  >>&/tmp/roboshop.log
go build >>&/tmp/roboshop.log

cp /root/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service >>&/tmp/roboshop.log

systemctl daemon-reload
systemctl enable dispatch  >>&/tmp/roboshop.log
systemctl restart dispatch
echo "dispatch started"