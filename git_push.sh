cd /home/k8s/k8s_init/
git add .
date=$(echo $(date))
git commit -m "$date"
git push git@gitee.com:myjconan/k8s.git master
