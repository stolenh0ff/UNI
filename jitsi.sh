sudo su -

read -p "AWS domain name: " your_domain
read -p "AWS public ip address: " public_ipadd

hostnamectl set-hostname $your_domain

printf "
127.0.0.1   $your_domain
$public_ipadd   $your_domain
" >> /etc/hosts

apt install openjdk-11-jre-headless nginx -y

echo "JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")" | sudo tee -a /etc/profile

source /etc/profile

systemctl start nginx.service

systemctl enable nginx.service

**Instalamos Jitsi**

curl https://download.jitsi.org/jitsi-key.gpg.key | sudo sh -c 'gpg --dearmor > /usr/share/keyrings/jitsi-keyring.gpg'

echo 'deb [signed-by=/usr/share/keyrings/jitsi-keyring.gpg] https://download.jitsi.org stable/' | sudo tee /etc/apt/sources.list.d/jitsi-stable.list > /dev/null

sudo apt-get update -y

printf "
*Colocar nombre de dominio en instalacion de jitsi y Seleccionamos la opcion Generate a new self-signed certificate
"

sudo apt install jitsi-meet -y

wget http://mirrors.edge.kernel.org/ubuntu/pool/universe/c/coturn/coturn_4.5.2-3.1_amd64.deb

sudo apt install ./coturn_4.5.2-3.1_amd64.deb

sudo apt install jitsi-meet-turnserver