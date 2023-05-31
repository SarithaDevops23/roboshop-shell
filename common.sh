output_log="/tmp/roboshop.log"
color="\e[33m"
nocolor="\e[0m"

app_user=roboshop
#mysql Password
mysql_password="RoboShop@1"
#rabbitmq-Password
rabbitmq_password="roboshop123"

application_preSetup(){
	echo -e "${color} user adding ${nocolor}"
	# id exit status 0 means user exists, 1 means no user found
	id $app_user
	if [ $? -ne 0 ]
	then
		useradd $app_user
	

	if [ $? -eq 0 ]; then
		echo SUCCESS
	else
		echo FAILURE
	fi

	echo -e $color" creating app dir"${nocolor}
	rm -rf /app
	mkdir /app 

	echo -e "${color} downloading application content ${nocolor}"
	curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$output_log
	cd /app 
	echo -e "${color} extracting downloaded content in application dirctory${nocolor}"
	unzip /tmp/$component.zip &>>$output_log }

Copying_Service_systemd_restart(){
	echo -e "${color} setup servive file into systemd directory ${nocolor}"
	cp /root/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$output_log

	echo -e "${color} daemon reload${nocolor}"
	systemctl daemon-reload
	systemctl enable $component
	echo -e "${color} restarting $component ${nocolor}"
	systemctl restart $component &>>$output_log
}

nodejs(){
	echo -e "${color}configuring nodejs repos${nocolor}"
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$output_log

	echo -e "${color}installing nodejs${nocolor}"
	yum install nodejs -y &>>$output_log

	application_preSetup

	cd /app 
	echo -e "${color} installing nodejs dependencies npm ${nocolor}"
	npm install &>>$output_log
    Copying_Service_systemd_restart
}

mongodb_load_schema(){
	echo -e "${color} copying mongodb repo in order to load schema we need this${nocolor}"
	cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo 
	echo -e "${color} installing mongodb client ${nocolor}"
	yum install mongodb-org-shell -y &>>output_log
	echo -e "${color} loading schema${nocolor}"
	mongo --host mongodb-dev.devops23.store </app/schema/$component.js &>>$output_log 
}