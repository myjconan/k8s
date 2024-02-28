修改application.properties中信息
1. mysql
2. redis
创建配置文件的configmap
#进入configmap目录
kubectl delete cm volvo-ema80-config && kubectl create cm volvo-ema80-config --from-file=application.properties=./application.properties --from-file=log4j2.xml=./log4j2.xml --from-file=start.sh=./start.sh --from-file=plugin.xml=./plugin.xml -n ema80-ns
kubectl delete cm volvo-nginx-config && kubectl create cm volvo-nginx-config --from-file=ema8.conf=./ema8.conf --from-file=nginx.default=./nginx.conf -n ema80-ns
#进入cert目录
kubectl delete cm volvo-nginx-cert && kubectl create cm volvo-nginx-cert --from-file=ca.crt=./ca.crt --from-file=server.key=./server.key --from-file=server.crt=./server.crt --from-file=web.pem=./web.pem --from-file=web.key=./web.key --from-file=mo.crt=./mo.crt --from-file=mo.key=./mo.key --from-file=app.key=./app.key --from-file=app.crt=./app.crt --from-file=moca.pem=./moca.pem -n ema80-ns
