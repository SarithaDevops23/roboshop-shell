source common.sh


echo -e "${color}Installing nginx server${nocolor}"
yum install nginx -y $outpit_log

echo -e "${color}Removing static content from server${nocolor}"
rm -rf /usr/share/nginx/html/* $outpit_log

echo -e "${color}downloading actual content from the project${nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip $outpit_log
echo -e "${color}unzipping downloaded content${nocolor}"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip $outpit_log

echo -e "${color}update frontend configuration${nocolor}"
cp /root/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf


systemctl enable nginx $outpit_log
systemctl restart nginx $outpit_log
echo -e "${color}installation done${nocolor}"