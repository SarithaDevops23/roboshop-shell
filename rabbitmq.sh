echo "configuring yum repos using script"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log
echo "configuring yum repo for rabbitmq"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log
echo "installing rabbitmq"
yum install rabbitmq-server -y &>>/tmp/roboshop.log
echo "starting rabbitmq server"
systemctl enable rabbitmq-server &>>/tmp/roboshop.log
systemctl restart rabbitmq-server 

echo "adding rabbitmq user"
rabbitmqctl add_user roboshop roboshop123 &>>/tmp/roboshop.log
echo "setting permissions to user and DONE"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log