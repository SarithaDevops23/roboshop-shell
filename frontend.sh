echo -e "\e[33mInstalling nginx server\e[0m"
yum install nginx -y 
rm -rf /usr/share/nginx/html/* 
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip

systemctl enable nginx 
systemctl restart nginx 
echo -e "\e[33minstallation done\e[0m"