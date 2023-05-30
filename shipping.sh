source common.sh
component=shipping

echo -e "${color} installing maven${nocolor}"
yum install maven -y &>>$output_log

application_preSetup

cd /app 
echo -e "${color}clean package${nocolor}"
mvn clean package &>>$output_log
mv target/$component-1.0.jar $component.jar &>>$output_log


echo -e "${color}installing mysql community version${nocolor}"
yum install mysql -y  &>>$output_log
echo -e "${color}Load schema${nocolor}"
mysql -h mysql-dev.devops23.store -uroot -p$mysql_password < /app/schema/$component.sql &>>$output_log

Copying_Service_systemd_restart