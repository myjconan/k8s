apt-get update
#jenkins pipeline�ر���
apt-get install -y jq
#vim�༭��
apt-get install -y vim
#������Կ�
apt-get install -y inetutils-ping
apt-get install -y telnet
apt-get install -y dnsutils
apt-get install -y iproute2 
apt-get install -y iptables
#k8s���
apt-get install -y apt-transport-https
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubectl
#apt-get install -y kubelet

