echo -e "\e[33mInstalling nginx server\e[0m"
yum install nginx -y 

echo -e "\e[33mRemoving static content from server\e[0m"
rm -rf /usr/share/nginx/html/* 

echo -e "\e[33mdownloading actual content from the project\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
echo -e "\e[33munzipping downloaded content\e[0m"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip

systemctl enable nginx 
systemctl restart nginx 
echo -e "\e[33minstallation done\e[0m"