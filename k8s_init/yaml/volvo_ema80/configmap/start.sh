#!/bin/sh
#init config
home_path=/home/dahantc/ema80
jar_path=/home/dahantc
[[ ! -d ${home_path}/config ]] && mkdir -p ${home_path}/config
pod_num=$(echo ${PodName:-1}|awk -F'-' '{print $NF+1}')
web_type=web
AppGroup=${AppGroup:-100}
[[ $(echo ${PodName}|grep -ic app) -eq 1 ]] && web_type=app
[[ ! -d ${home_path}/resource ]] && cp /data/resource ${home_path}/ -rf || (rm ${home_path}/resource/plugins -rf && cp /data/resource/plugins ${home_path}/resource -rf)
[[ ${web_type} == "app" &&  ! -d ${home_path}/resource/plugins/emaApp00${pod_num} ]] && cp ${home_path}/resource/plugins/emaApp001 ${home_path}/resource/plugins/emaApp00${pod_num} -rf
if [[ ${web_type} == "web" ]];then
       sed "s/{{APP_PORT}}/8080/g;s/{{AppDeployIp}}/${AppDeployIp}/g;s/{{APPID}}/emaWeb00${pod_num}/g;s/{{AppGroup}}/${AppGroup}/g;" /data/config/application.properties >${home_path}/config/application.properties
       sed "s#{{LOG_PATH}}#${jar_path}/logs#g;s#{{LOG_NAME}}#web-00${pod_num}#g" /data/config/log4j2.xml > ${home_path}/config/log4j2.xml
   else
     #app
       sed "s/{{APP_PORT}}/8181/g;s/{{AppDeployIp}}/${AppDeployIp}/g;s/{{APPID}}/emaApp00${pod_num}/g;s/{{AppGroup}}/${AppGroup}/g;" /data/config/application.properties >${home_path}/config/application.properties
       sed "s#{{LOG_PATH}}#${jar_path}/logs#g;s#{{LOG_NAME}}#app-00${pod_num}#g" /data/config/log4j2.xml > ${home_path}/config/log4j2.xml
       plugin_name=$(ls /home/dahantc/ema80/resource/plugins/emaApp00${pod_num}/ics_plugins|grep ctc-ema-ics2-plugin-volvo|grep -v zip)
       cat /data/config/plugin.xml > /home/dahantc/ema80/resource/plugins/emaApp00${pod_num}/ics_plugins/${plugin_name}/plugin.xml 
       #cat /data/config/plugin.xml > /home/dahantc/ema80/resource/plugins/emaApp00${pod_num}/ics_plugins/ctc-ema-ics2-plugin-volvo-1.0.35/plugin.xml 
fi

min=${MEM:-4096}m
max=${MEM:-4096}m
jar_name=$(find ${jar_path} -maxdepth 1 -name "*.jar"|awk -F '/' '{print $NF}')
[[ ${jar_name} == "" ]] && exit 1
[[ ! -f ${home_path}/config/application.properties ]] && exit 2
#[[ -f /data/config/iscservicesadapter.properties ]] && cat /data/config/iscservicesadapter.properties > ${home_path}/config/iscservicesadapter.properties
cd ${jar_path} && jar -uvf0 ${jar_name} BOOT-INF
java  -Xdebug -Xrunjdwp:transport=dt_socket,address=8050,server=y,suspend=n -Djava.security.egd=file:/dev/urandom -Xms${min} -Xmx${max} -Xbootclasspath/a:${home_path}/config -jar ${jar_path}/${jar_name}
