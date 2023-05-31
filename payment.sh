source common.sh
component=payment
rabbitmq_user=$1
rabbitmq_password=$2

echo "installing python"
yum install python36 gcc python3-devel -y &>>$output_log

application_preSetup

cd /app 
echo "installing dependencies"
pip3.6 install -r requirements.txt &>>$output_log

Copying_Service_systemd_restart