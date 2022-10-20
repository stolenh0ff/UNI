read -p "AWS domain name: " your_domain
read -p "AWS public ip address: " public_ipadd

printf "
127.0.0.1   $your_domain
$public_ipadd   $your_domain
"