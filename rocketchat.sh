#inputs
read -p "AWS domain_name: " your_domain
sudo apt install wget nginx apt-transport-https gnupg2 software-properties-common -y
sudo snap install rocketchat-server
sudo systemctl start nginx.service
sudo systemctl enable nginx.service
sudo touch /etc/nginx/conf.d/rocketchat.conf
sudo echo "
server {
        listen 80;
        server_name $your_domain;
        error_log /var/log/nginx/rocketchat_error.log;
        location / {
            proxy_pass http://127.0.0.1:3000/;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_set_header Host $http_host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto http;
            proxy_set_header X-Nginx-Proxy true;
            proxy_redirect off;
        }
    }
" >> /etc/nginx/conf.d/rocketchat.conf
sudo nginx -t
sudo systemctl restart nginx
printf "READY!!!"
#sudo reboot