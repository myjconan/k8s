apt-get update
#jenkins pipeline±Ø±¸¿â
apt-get install -y jq
#vim±à¼­Æ÷
apt-get install -y vim
#ÍøÂç²âÊÔ¿â
apt-get install -y inetutils-ping
apt-get install -y telnet
apt-get install -y dnsutils
apt-get install -y iproute2 
apt-get install -y iptables
#k8sÏà¹Ø
apt-get install -y apt-transport-https
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubectl
#apt-get install -y kubelet

